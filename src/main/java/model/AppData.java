package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class AppData implements Serializable {
    private static final long serialVersionUID = 1L;

    private Map<String, Usuario> usuarios = new LinkedHashMap<>();
    private Map<Integer, Semana> semanas = new LinkedHashMap<>();
    private List<Proyecto> proyectos = new ArrayList<>();
    private Perfil perfil;

    public Map<String, Usuario> getUsuarios() { return usuarios; }
    public void setUsuarios(Map<String, Usuario> usuarios) { this.usuarios = usuarios; }

    public Map<Integer, Semana> getSemanas() { return semanas; }
    public void setSemanas(Map<Integer, Semana> semanas) { this.semanas = semanas; }

    public List<Proyecto> getProyectos() { return proyectos; }
    public void setProyectos(List<Proyecto> proyectos) { this.proyectos = proyectos; }

    public Perfil getPerfil() { return perfil; }
    public void setPerfil(Perfil perfil) { this.perfil = perfil; }
}
