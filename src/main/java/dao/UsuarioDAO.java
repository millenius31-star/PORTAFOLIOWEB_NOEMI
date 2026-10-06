package dao;

import model.Usuario;
import util.PasswordUtil;

public class UsuarioDAO {
    private final DataStore store = DataStore.get();

    public Usuario autenticar(String usuario, String password) {
        if (usuario == null || password == null) return null;
        String key = usuario.trim().toLowerCase();
        Usuario u = store.data().getUsuarios().get(key);
        return u != null && PasswordUtil.coincide(password, u.getPasswordHash()) ? u : null;
    }

    public synchronized boolean registrar(String nombre, String usuario, String password) {
        if (usuario == null || usuario.isBlank()) return false;
        String key = usuario.trim().toLowerCase();
        if (store.data().getUsuarios().containsKey(key)) return false;
        store.data().getUsuarios().put(key,
                new Usuario(nombre, key, PasswordUtil.hash(password), "USUARIO"));
        store.guardar();
        return true;
    }
}
