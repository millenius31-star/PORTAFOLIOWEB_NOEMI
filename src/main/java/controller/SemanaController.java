package controller;

import dao.SemanaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Semana;
import util.WebUtil;

import java.io.IOException;

@WebServlet("/semanas")
public class SemanaController extends HttpServlet {
    private final SemanaDAO semanaDAO = new SemanaDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("semanas", semanaDAO.listar());
        req.getRequestDispatcher("/semanas.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");
        if (!WebUtil.esAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }
        String accion = WebUtil.texto(req, "accion");
        try {
            int numero = Integer.parseInt(WebUtil.texto(req, "numero"));
            if ("eliminar".equals(accion)) {
                semanaDAO.eliminar(numero);
            } else {
                String titulo = WebUtil.texto(req, "titulo");
                String descripcion = WebUtil.texto(req, "descripcion");
                Semana existente = semanaDAO.buscar(numero);
                if (existente == null) existente = new Semana(numero, titulo, descripcion);
                existente.setTitulo(titulo.isBlank() ? "Semana " + numero : titulo);
                existente.setDescripcion(descripcion);
                semanaDAO.guardar(existente);
            }
        } catch (NumberFormatException ignored) {}
        resp.sendRedirect(req.getContextPath() + "/dashboard");
    }
}
