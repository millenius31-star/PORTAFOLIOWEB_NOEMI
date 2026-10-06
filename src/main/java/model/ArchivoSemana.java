package model;

import java.io.Serializable;

public class ArchivoSemana implements Serializable {
    private static final long serialVersionUID = 1L;
    private String id;
    private String nombreOriginal;
    private String nombreGuardado;
    private long tamano;
    private String tipo; // PROFESOR, ALUMNO o GENERAL para archivos antiguos

    public ArchivoSemana() {}

    public ArchivoSemana(String id, String nombreOriginal, String nombreGuardado, long tamano) {
        this(id, nombreOriginal, nombreGuardado, tamano, "GENERAL");
    }

    public ArchivoSemana(String id, String nombreOriginal, String nombreGuardado, long tamano, String tipo) {
        this.id = id;
        this.nombreOriginal = nombreOriginal;
        this.nombreGuardado = nombreGuardado;
        this.tamano = tamano;
        this.tipo = tipo;
    }

    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    public String getNombreOriginal() { return nombreOriginal; }
    public void setNombreOriginal(String nombreOriginal) { this.nombreOriginal = nombreOriginal; }
    public String getNombreGuardado() { return nombreGuardado; }
    public void setNombreGuardado(String nombreGuardado) { this.nombreGuardado = nombreGuardado; }
    public long getTamano() { return tamano; }
    public void setTamano(long tamano) { this.tamano = tamano; }

    public String getTipo() {
        return (tipo == null || tipo.isBlank()) ? "GENERAL" : tipo;
    }
    public void setTipo(String tipo) { this.tipo = tipo; }

    public String getTipoEtiqueta() {
        if ("PROFESOR".equalsIgnoreCase(getTipo())) return "Profesor";
        if ("ALUMNO".equalsIgnoreCase(getTipo())) return "Alumno";
        return "General";
    }
}
