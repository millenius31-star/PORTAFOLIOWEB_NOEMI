
package dao;

import model.ArchivoSemana;
import model.Semana;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class SemanaDAO {

    private final DataStore store = DataStore.get();

    private final ArchivoSemanaDAO archivoDAO =
            new ArchivoSemanaDAO();

    public List<Semana> listar() {

        List<Semana> lista = new ArrayList<>(
                store.data().getSemanas().values());

        lista.sort(
                Comparator.comparingInt(Semana::getNumero));

        for (Semana semana : lista) {
            cargarArchivos(semana);
        }

        return lista;
    }

    public Semana buscar(int numero) {

        Semana semana =
                store.data().getSemanas().get(numero);

        if (semana != null) {
            cargarArchivos(semana);
        }

        return semana;
    }

    private synchronized void cargarArchivos(Semana semana) {

        List<ArchivoSemana> archivos =
                archivoDAO.listar(semana.getNumero());

        semana.getArchivos().clear();
        semana.getArchivos().addAll(archivos);
    }

    public synchronized void guardar(Semana semana) {

        store.data().getSemanas().put(
                semana.getNumero(), semana);

        store.guardar();
    }

    public synchronized void eliminar(int numero) {

        store.data().getSemanas().remove(numero);
        store.guardar();
    }

    public ArchivoSemana buscarArchivo(String id) {

        return archivoDAO.buscar(id);
    }

    public synchronized boolean quitarArchivo(String id) {

        return archivoDAO.eliminar(id);
    }
}
