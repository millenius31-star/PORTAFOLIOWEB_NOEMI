
package controller;

import dao.ArchivoSemanaDAO;
import dao.SemanaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.ArchivoSemana;
import model.Semana;
import util.SupabaseStorage;
import util.WebUtil;

import java.io.IOException;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.UUID;

@WebServlet("/archivo")
@MultipartConfig(
    maxFileSize = 20L * 1024 * 1024,
    maxRequestSize = 200L * 1024 * 1024
)
public class ArchivoController extends HttpServlet {

    private final SemanaDAO semanaDAO = new SemanaDAO();
    private final ArchivoSemanaDAO archivoDAO =
            new ArchivoSemanaDAO();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp) throws IOException {

        String id = req.getParameter("id");
        ArchivoSemana a = archivoDAO.buscar(id);

        if (a == null) {
            resp.sendError(404);
            return;
        }

        String nombre = URLEncoder.encode(
                a.getNombreOriginal(),
                StandardCharsets.UTF_8
        ).replace("+", "%20");

        boolean ver = "ver".equalsIgnoreCase(
                req.getParameter("accion"));

        String mime = URLConnection.guessContentTypeFromName(
                a.getNombreOriginal());

        boolean visualizable = mime != null &&
                (mime.equals("application/pdf")
                || mime.equals("image/png")
                || mime.equals("image/jpeg")
                || mime.equals("image/gif")
                || mime.equals("image/webp")
                || mime.equals("text/plain"));

        try (var in = SupabaseStorage.descargar(
                a.getNombreGuardado())) {

            resp.setHeader("X-Content-Type-Options", "nosniff");

            resp.setHeader(
                "Content-Disposition",
                (ver && visualizable ? "inline" : "attachment")
                + "; filename*=UTF-8''" + nombre
            );

            resp.setContentType(
                ver && visualizable
                ? mime : "application/octet-stream"
            );

            resp.setContentLengthLong(a.getTamano());

            in.transferTo(resp.getOutputStream());
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws IOException, ServletException {

        req.setCharacterEncoding("UTF-8");

        if (!WebUtil.esAdmin(req)) {
            resp.sendError(403);
            return;
        }

        String accion = WebUtil.texto(req, "accion");
        String origen = WebUtil.texto(req, "origen");

        if ("eliminar".equals(accion)) {

            String id = WebUtil.texto(req, "id");
            ArchivoSemana a = archivoDAO.buscar(id);

            if (a != null) {
                SupabaseStorage.eliminar(a.getNombreGuardado());
                archivoDAO.eliminar(id);
            }

            resp.sendRedirect(req.getContextPath()
                    + "/dashboard#administrar-semanas");
            return;
        }

        int semanaNumero;

        try {
            semanaNumero = Integer.parseInt(
                    WebUtil.texto(req, "semana"));
        } catch (NumberFormatException e) {
            resp.sendError(400);
            return;
        }

        if (semanaNumero < 1 || semanaNumero > 16) {
            resp.sendError(400);
            return;
        }

        Semana s = semanaDAO.buscar(semanaNumero);

        if (s == null) {
            resp.sendError(404, "Semana no encontrada");
            return;
        }

        String tipo = WebUtil.texto(req, "tipo").toUpperCase();

        if (!"PROFESOR".equals(tipo)
                && !"ALUMNO".equals(tipo)) {
            tipo = "ALUMNO";
        }

        String carpeta = "PROFESOR".equals(tipo)
                ? "profesor" : "alumno";

        for (Part part : req.getParts()) {

            if (!"archivo".equals(part.getName())
                    || part.getSize() <= 0) {
                continue;
            }

            String original = part.getSubmittedFileName();

            if (original == null || original.isBlank()) {
                continue;
            }

            original = original.replace('\\', '/');
            original = original.substring(
                    original.lastIndexOf('/') + 1);

            if (original.isBlank()) continue;

            String id = UUID.randomUUID().toString();

            String extension = "";
            int pos = original.lastIndexOf('.');

            if (pos >= 0) {
                String ext = original.substring(pos);
                if (ext.matches("\\.[a-zA-Z0-9]{1,10}")) {
                    extension = ext;
                }
            }

            String ruta = String.format(
                    "semana-%02d/%s/%s%s",
                    semanaNumero, carpeta, id, extension);

            byte[] datos;

            try (var in = part.getInputStream()) {
                datos = in.readAllBytes();
            }

            SupabaseStorage.subir(ruta, datos);

            ArchivoSemana archivo = new ArchivoSemana(
                    id,
                    original,
                    ruta,
                    part.getSize(),
                    tipo
            );

            try {
                archivoDAO.guardar(semanaNumero, archivo);
            } catch (RuntimeException e) {
                try {
                    SupabaseStorage.eliminar(ruta);
                } catch (IOException limpieza) {
                    e.addSuppressed(limpieza);
                }
                throw new ServletException(
                        "No se pudo registrar el archivo", e);
            }
        }

        if ("dashboard".equalsIgnoreCase(origen)) {

            resp.sendRedirect(req.getContextPath()
                    + "/dashboard#administrar-semanas");

        } else {

            resp.sendRedirect(req.getContextPath()
                    + "/?view=semanas&openWeek="
                    + semanaNumero);
        }
    }
}
