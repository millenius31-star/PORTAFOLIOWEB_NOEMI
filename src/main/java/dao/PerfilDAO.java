package dao;

import model.Perfil;

public class PerfilDAO {
    private final DataStore store = DataStore.get();

    public Perfil obtener() {
        return store.data().getPerfil();
    }

    public synchronized void guardar(Perfil perfil) {
        store.data().setPerfil(perfil);
        store.guardar();
    }
}
