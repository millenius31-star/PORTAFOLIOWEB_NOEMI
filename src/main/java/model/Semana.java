package model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Semana implements Serializable {
    private static final long serialVersionUID = 1L;
    private int numero;
    private String titulo;
    private String descripcion;
    private List<ArchivoSemana> archivos = new ArrayList<>();

    public Semana() {}

    public Semana(int numero, String titulo, String descripcion) {
        this.numero = numero;
        this.titulo = titulo;
        this.descripcion = descripcion;
    }

    public int getNumero() { return numero; }
    public void setNumero(int numero) { this.numero = numero; }
    public String getTitulo() { return titulo; }
    public void setTitulo(String titulo) { this.titulo = titulo; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public List<ArchivoSemana> getArchivos() { return archivos; }
    public void setArchivos(List<ArchivoSemana> archivos) { this.archivos = archivos; }
}
