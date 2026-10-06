package controller;

import dao.PerfilDAO;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Perfil;
import util.WebUtil;

import java.io.IOException;

@WebServlet("/perfil")
public class PerfilController extends HttpServlet {
    private final PerfilDAO dao = new PerfilDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        req.setCharacterEncoding("UTF-8");

        if (!WebUtil.esAdmin(req)) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        Perfil p = dao.obtener();
        if (p == null) p = new Perfil();

        p.setNombre(WebUtil.texto(req, "nombre"));
        p.setCarrera(WebUtil.texto(req, "carrera"));
        p.setCurso(WebUtil.texto(req, "curso"));
        p.setPresentacion(WebUtil.texto(req, "presentacion"));
        p.setObjetivo(WebUtil.texto(req, "objetivo"));
        p.setFormaTrabajo(WebUtil.texto(req, "formaTrabajo"));
        p.setIntereses(WebUtil.texto(req, "intereses"));
        p.setHabilidades(WebUtil.texto(req, "habilidades"));
        p.setVision(WebUtil.texto(req, "vision"));
        p.setEnfoqueProyecto(WebUtil.texto(req, "enfoqueProyecto"));

        dao.guardar(p);
        resp.sendRedirect(req.getContextPath() + "/dashboard#editar-sobre-mi");
    }
}
