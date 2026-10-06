package controller;

import dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import util.WebUtil;

import java.io.IOException;

@WebServlet("/registro")
public class RegistroController extends HttpServlet {
    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/registro.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String nombre = WebUtil.texto(req, "nombre");
        String usuario = WebUtil.texto(req, "usuario");
        String password = WebUtil.texto(req, "password");
        if (nombre.isBlank() || usuario.isBlank() || password.length() < 6) {
            req.setAttribute("error", "Completa los datos. La contraseña debe tener al menos 6 caracteres.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }
        if (!usuarioDAO.registrar(nombre, usuario, password)) {
            req.setAttribute("error", "Ese usuario ya existe.");
            req.getRequestDispatcher("/registro.jsp").forward(req, resp);
            return;
        }
        req.setAttribute("ok", "Cuenta creada. Ya puedes iniciar sesión.");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }
}
