package util;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.Usuario;

public final class WebUtil {
    private WebUtil() {}

    public static String texto(HttpServletRequest req, String nombre) {
        String v = req.getParameter(nombre);
        return v == null ? "" : v.trim();
    }

    public static Usuario usuarioActual(HttpServletRequest req) {
        HttpSession s = req.getSession(false);
        return s == null ? null : (Usuario) s.getAttribute("usuarioActual");
    }

    public static boolean esAdmin(HttpServletRequest req) {
        Usuario u = usuarioActual(req);
        return u != null && u.isAdmin();
    }
}
