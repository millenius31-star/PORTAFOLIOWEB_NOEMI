package controller;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.Usuario;
import util.WebUtil;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String usuario = WebUtil.texto(req, "usuario");
        String password = WebUtil.texto(req, "password");
        Usuario encontrado = usuarioDAO.autenticar(usuario, password);
        if (encontrado == null) {
            req.setAttribute("error", "Usuario o contraseña incorrectos.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        req.getSession(true).setAttribute("usuarioActual", encontrado);
        resp.sendRedirect(req.getContextPath() + (encontrado.isAdmin() ? "/dashboard" : "/semanas"));
    }
}
