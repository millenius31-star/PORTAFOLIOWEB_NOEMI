package controller;

import dao.DataStore;
import dao.SemanaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ArchivoSemana;
import model.Semana;
import util.WebUtil;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.nio.file.*;
import java.util.UUID;

@WebServlet("/archivo")
@MultipartConfig(maxFileSize = 20L * 1024 * 1024, maxRequestSize = 200L * 1024 * 1024)
public class ArchivoController extends HttpServlet {
    private final SemanaDAO semanaDAO = new SemanaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String id = req.getParameter("id");
        ArchivoSemana a = semanaDAO.buscarArchivo(id);
        if (a == null) { resp.sendError(404); return; }

        Path archivo = DataStore.get().uploadsDir().resolve(a.getNombreGuardado()).normalize();
        if (!archivo.startsWith(DataStore.get().uploadsDir()) || !Files.exists(archivo)) {
            resp.sendError(404);
            return;
        }

        String nombre = URLEncoder.encode(a.getNombreOriginal(), StandardCharsets.UTF_8).replace("+", "%20");
        resp.setHeader("Content-Disposition", "attachment; filename*=UTF-8''" + nombre);
        resp.setContentType("application/octet-stream");
        resp.setContentLengthLong(Files.size(archivo));
        Files.copy(archivo, resp.getOutputStream());
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8");
        String accion = WebUtil.texto(req, "accion");
        String origen = WebUtil.texto(req, "origen");

        // Eliminar sigue siendo una acción exclusiva del administrador.
        if ("eliminar".equals(accion)) {
            if (!WebUtil.esAdmin(req)) { resp.sendError(403); return; }
            String id = WebUtil.texto(req, "id");
            ArchivoSemana a = semanaDAO.buscarArchivo(id);
            if (a != null) {
                Path archivo = DataStore.get().uploadsDir().resolve(a.getNombreGuardado()).normalize();
                if (archivo.startsWith(DataStore.get().uploadsDir())) Files.deleteIfExists(archivo);
                semanaDAO.quitarArchivo(id);
            }
            resp.sendRedirect(req.getContextPath() + "/dashboard#administrar-semanas");
            return;
        }

        int semanaNumero;
        try {
            semanaNumero = Integer.parseInt(WebUtil.texto(req, "semana"));
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/");
            return;
        }

        Semana s = semanaDAO.buscar(semanaNumero);
        if (s == null) {
            resp.sendError(404, "Semana no encontrada");
            return;
        }

        String tipo = WebUtil.texto(req, "tipo").toUpperCase();
        if (!"PROFESOR".equals(tipo) && !"ALUMNO".equals(tipo)) tipo = "ALUMNO";

        // Permite seleccionar y subir varios archivos en una sola operación.
        // Todos los <input type="file" name="archivo" multiple> llegan como
        // varias partes con el mismo nombre "archivo".
        boolean seSubioAlMenosUno = false;
        Path carpeta = DataStore.get().carpetaSemana(semanaNumero, tipo);
        String rolFolder = "PROFESOR".equals(tipo) ? "profesor" : "alumno";

        for (Part part : req.getParts()) {
            if (!"archivo".equals(part.getName()) || part.getSize() <= 0) continue;

            String submitted = part.getSubmittedFileName();
            if (submitted == null || submitted.isBlank()) continue;

            String original = Paths.get(submitted).getFileName().toString();
            if (original.isBlank()) continue;

            String id = UUID.randomUUID().toString();
            String extension = "";
            int pos = original.lastIndexOf('.');
            if (pos >= 0 && pos < original.length() - 1) {
                extension = original.substring(pos);
            }

            String guardadoSimple = id + extension;
            Path destino = carpeta.resolve(guardadoSimple).normalize();
            if (!destino.startsWith(carpeta)) {
                resp.sendError(400);
                return;
            }

            try (var in = part.getInputStream()) {
                Files.copy(in, destino, StandardCopyOption.REPLACE_EXISTING);
            }

            String relativo = String.format("semana-%02d/%s/%s", semanaNumero, rolFolder, guardadoSimple);
            s.getArchivos().add(new ArchivoSemana(id, original, relativo, part.getSize(), tipo));
            seSubioAlMenosUno = true;
        }

        if (seSubioAlMenosUno) {
            semanaDAO.guardar(s);
        }

        if ("dashboard".equalsIgnoreCase(origen)) {
            resp.sendRedirect(req.getContextPath() + "/dashboard#administrar-semanas");
        } else {
            resp.sendRedirect(req.getContextPath() + "/?view=semanas&openWeek=" + semanaNumero);
        }
    }
}
