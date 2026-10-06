package model;

import java.io.Serializable;

public class Proyecto implements Serializable {
    private static final long serialVersionUID = 1L;

    private long id;
    private String titulo;
    private String descripcion;
    private String tecnologia;
    private String categoria;
    private String aprendizaje;

    public Proyecto() {}

    public Proyecto(String titulo, String descripcion, String tecnologia) {
        this(0, titulo, descripcion, tecnologia, "Proyecto web", "");
    }

    public Proyecto(long id, String titulo, String descripcion, String tecnologia,
                    String categoria, String aprendizaje) {
        this.id = id;
        this.titulo = titulo;
        this.descripcion = descripcion;
        this.tecnologia = tecnologia;
        this.categoria = categoria;
        this.aprendizaje = aprendizaje;
    }

    public long getId() { return id; }
    public void setId(long id) { this.id = id; }

    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public String getTecnologia() { return tecnologia; }
    public void setTecnologia(String tecnologia) { this.tecnologia = tecnologia; }

    public String getCategoria() { return categoria; }
    public void setCategoria(String categoria) { this.categoria = categoria; }

    public String getAprendizaje() { return aprendizaje; }
    public void setAprendizaje(String aprendizaje) { this.aprendizaje = aprendizaje; }
}
