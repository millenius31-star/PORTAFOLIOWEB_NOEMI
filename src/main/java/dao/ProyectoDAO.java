package dao;

import model.Proyecto;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class ProyectoDAO {
    private final DataStore store = DataStore.get();

    public List<Proyecto> listar() {
        List<Proyecto> lista = new ArrayList<>(store.data().getProyectos());
        lista.sort(Comparator.comparingLong(Proyecto::getId));
        return lista;
    }

    public Proyecto buscar(long id) {
        for (Proyecto p : store.data().getProyectos()) {
            if (p.getId() == id) return p;
        }
        return null;
    }

    public synchronized Proyecto guardar(Proyecto proyecto) {
        if (proyecto.getId() <= 0) {
            long nuevoId = 1;
            for (Proyecto p : store.data().getProyectos()) {
                nuevoId = Math.max(nuevoId, p.getId() + 1);
            }
            proyecto.setId(nuevoId);
            store.data().getProyectos().add(proyecto);
        } else {
            Proyecto existente = buscar(proyecto.getId());
            if (existente == null) {
                store.data().getProyectos().add(proyecto);
            } else {
                existente.setTitulo(proyecto.getTitulo());
                existente.setDescripcion(proyecto.getDescripcion());
                existente.setTecnologia(proyecto.getTecnologia());
                existente.setCategoria(proyecto.getCategoria());
                existente.setAprendizaje(proyecto.getAprendizaje());
            }
        }

        store.guardar();
        return proyecto;
    }

    public synchronized void eliminar(long id) {
        store.data().getProyectos().removeIf(p -> p.getId() == id);
        store.guardar();
    }
}
