package controller;

import dao.ProyectoDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Proyecto;
import util.WebUtil;

import java.io.IOException;

@WebServlet("/proyectos")
public class ProyectoController extends HttpServlet {
    private final ProyectoDAO dao = new ProyectoDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("proyectos", dao.listar());
        req.getRequestDispatcher("/proyectos.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        req.setCharacterEncoding("UTF-8");

        if (!WebUtil.esAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String accion = WebUtil.texto(req, "accion");

        if ("eliminar".equals(accion)) {
            try {
                dao.eliminar(Long.parseLong(WebUtil.texto(req, "id")));
            } catch (NumberFormatException ignored) {}
            resp.sendRedirect(req.getContextPath() + "/dashboard#administrar-proyectos");
            return;
        }

        long id = 0;
        try {
            id = Long.parseLong(WebUtil.texto(req, "id"));
        } catch (NumberFormatException ignored) {}

        Proyecto p = new Proyecto();
        p.setId(id);
        p.setTitulo(WebUtil.texto(req, "titulo"));
        p.setDescripcion(WebUtil.texto(req, "descripcion"));
        p.setTecnologia(WebUtil.texto(req, "tecnologia"));
        p.setCategoria(WebUtil.texto(req, "categoria"));
        p.setAprendizaje(WebUtil.texto(req, "aprendizaje"));

        if (p.getTitulo().isBlank()) p.setTitulo("Nuevo proyecto");
        if (p.getCategoria().isBlank()) p.setCategoria("Proyecto web");

        dao.guardar(p);
        resp.sendRedirect(req.getContextPath() + "/dashboard#administrar-proyectos");
    }
}
