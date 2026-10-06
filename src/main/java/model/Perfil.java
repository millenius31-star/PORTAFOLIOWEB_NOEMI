package model;

import java.io.Serializable;

public class Perfil implements Serializable {
    private static final long serialVersionUID = 1L;

    private String nombre;
    private String carrera;
    private String curso;
    private String presentacion;
    private String objetivo;
    private String formaTrabajo;
    private String intereses;
    private String habilidades;
    private String vision;
    private String enfoqueProyecto;

    public Perfil() {}

    public Perfil(String nombre, String carrera, String curso, String presentacion,
                  String objetivo, String formaTrabajo, String intereses,
                  String habilidades, String vision, String enfoqueProyecto) {
        this.nombre = nombre;
        this.carrera = carrera;
        this.curso = curso;
        this.presentacion = presentacion;
        this.objetivo = objetivo;
        this.formaTrabajo = formaTrabajo;
        this.intereses = intereses;
        this.habilidades = habilidades;
        this.vision = vision;
        this.enfoqueProyecto = enfoqueProyecto;
    }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getCarrera() { return carrera; }
    public void setCarrera(String carrera) { this.carrera = carrera; }

    public String getCurso() { return curso; }
    public void setCurso(String curso) { this.curso = curso; }

    public String getPresentacion() { return presentacion; }
    public void setPresentacion(String presentacion) { this.presentacion = presentacion; }

    public String getObjetivo() { return objetivo; }
    public void setObjetivo(String objetivo) { this.objetivo = objetivo; }

    public String getFormaTrabajo() { return formaTrabajo; }
    public void setFormaTrabajo(String formaTrabajo) { this.formaTrabajo = formaTrabajo; }

    public String getIntereses() { return intereses; }
    public void setIntereses(String intereses) { this.intereses = intereses; }

    public String getHabilidades() { return habilidades; }
    public void setHabilidades(String habilidades) { this.habilidades = habilidades; }

    public String getVision() { return vision; }
    public void setVision(String vision) { this.vision = vision; }

    public String getEnfoqueProyecto() { return enfoqueProyecto; }
    public void setEnfoqueProyecto(String enfoqueProyecto) { this.enfoqueProyecto = enfoqueProyecto; }
}
