package dao;

import model.ArchivoSemana;
import model.Semana;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public class SemanaDAO {
    private final DataStore store = DataStore.get();

    public List<Semana> listar() {
        List<Semana> lista = new ArrayList<>(store.data().getSemanas().values());
        lista.sort(Comparator.comparingInt(Semana::getNumero));
        return lista;
    }

    public Semana buscar(int numero) {
        return store.data().getSemanas().get(numero);
    }

    public synchronized void guardar(Semana semana) {
        store.data().getSemanas().put(semana.getNumero(), semana);
        store.guardar();
    }

    public synchronized void eliminar(int numero) {
        store.data().getSemanas().remove(numero);
        store.guardar();
    }

    public ArchivoSemana buscarArchivo(String id) {
        for (Semana s : listar()) {
            for (ArchivoSemana a : s.getArchivos()) {
                if (a.getId().equals(id)) return a;
            }
        }
        return null;
    }

    public synchronized boolean quitarArchivo(String id) {
        for (Semana s : listar()) {
            ArchivoSemana encontrado = null;
            for (ArchivoSemana a : s.getArchivos()) {
                if (a.getId().equals(id)) { encontrado = a; break; }
            }
            if (encontrado != null) {
                s.getArchivos().remove(encontrado);
                store.guardar();
                return true;
            }
        }
        return false;
    }
}
