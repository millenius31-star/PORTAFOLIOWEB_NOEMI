package controller;

import dao.PerfilDAO;
import dao.ProyectoDAO;
import dao.SemanaDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private final SemanaDAO semanaDAO = new SemanaDAO();
    private final ProyectoDAO proyectoDAO = new ProyectoDAO();
    private final PerfilDAO perfilDAO = new PerfilDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("semanas", semanaDAO.listar());
        req.setAttribute("proyectos", proyectoDAO.listar());
        req.setAttribute("perfil", perfilDAO.obtener());
        req.getRequestDispatcher("/dashboard.jsp").forward(req, resp);
    }
}
