package dao;

import model.AppData;
import model.Perfil;
import model.Proyecto;
import model.Semana;
import model.Usuario;
import util.PasswordUtil;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public final class DataStore {
    private static final DataStore INSTANCIA = new DataStore();

    private final Path baseDir;
    private final Path dataFile;
    private final Path uploadsDir;
    private AppData data;

    private DataStore() {
        baseDir = Paths.get(System.getProperty("user.home"), ".portfolio-noemi");
        dataFile = baseDir.resolve("datos.bin");
        uploadsDir = baseDir.resolve("uploads");

        try {
            Files.createDirectories(uploadsDir);
        } catch (IOException e) {
            throw new IllegalStateException("No se pudo preparar el almacenamiento", e);
        }

        cargar();
        prepararCarpetasIniciales();
    }

    public static DataStore get() { return INSTANCIA; }
    public synchronized AppData data() { return data; }
    public Path uploadsDir() { return uploadsDir; }

    public Path carpetaSemana(int numero, String tipo) {
        String rol = "ALUMNO".equalsIgnoreCase(tipo) ? "alumno" : "profesor";
        Path carpeta = uploadsDir.resolve(String.format("semana-%02d", numero)).resolve(rol);
        try {
            Files.createDirectories(carpeta);
        } catch (IOException e) {
            throw new IllegalStateException("No se pudo crear la carpeta de la semana", e);
        }
        return carpeta;
    }

    private void prepararCarpetasIniciales() {
        for (int i = 1; i <= 16; i++) {
            carpetaSemana(i, "PROFESOR");
            carpetaSemana(i, "ALUMNO");
        }
    }

    private void cargar() {
        if (Files.exists(dataFile)) {
            try (ObjectInputStream in = new ObjectInputStream(Files.newInputStream(dataFile))) {
                data = (AppData) in.readObject();
                garantizarAdministradorActual();
                garantizarPerfil();
                garantizarIdsProyectos();
                guardar();
                return;
            } catch (Exception ignored) {
                // Si los datos anteriores no son compatibles o están dañados,
                // se crea nuevamente la información inicial.
            }
        }

        data = datosIniciales();
        guardar();
    }

    public synchronized void guardar() {
        try {
            Files.createDirectories(baseDir);
            try (ObjectOutputStream out = new ObjectOutputStream(Files.newOutputStream(dataFile))) {
                out.writeObject(data);
            }
        } catch (IOException e) {
            throw new IllegalStateException("No se pudieron guardar los datos", e);
        }
    }

    private void garantizarAdministradorActual() {
        data.getUsuarios().remove("noemi");
        data.getUsuarios().remove("noemi@gmail.com");

        Usuario admin = new Usuario(
                "Noemi Capcha Advincula",
                "noemi@gmail.com",
                PasswordUtil.hash("12345678"),
                "ADMIN"
        );
        data.getUsuarios().put(admin.getUsuario(), admin);
    }

    private void garantizarPerfil() {
        if (data.getPerfil() == null) {
            data.setPerfil(perfilInicial());
        }
    }

    private void garantizarIdsProyectos() {
        long siguiente = 1;
        for (Proyecto p : data.getProyectos()) {
            if (p.getId() <= 0) {
                p.setId(siguiente);
            }
            siguiente = Math.max(siguiente, p.getId() + 1);

            if (p.getCategoria() == null || p.getCategoria().isBlank()) {
                p.setCategoria("Proyecto web");
            }
            if (p.getAprendizaje() == null) {
                p.setAprendizaje("");
            }
        }
    }

    private Perfil perfilInicial() {
        return new Perfil(
            "Noemi Capcha Advincula",
            "Diseño y Programación Web",
            "Proyecto de aplicación profesional",
            "Soy estudiante de Diseño y Programación Web y me interesa crear soluciones digitales que combinen una interfaz visual clara con programación funcional. Este portafolio documenta mi proceso de aprendizaje y reúne las evidencias más importantes desarrolladas durante el curso.",
            "Fortalecer mis capacidades para analizar necesidades, diseñar interfaces, desarrollar aplicaciones web responsive y administrar contenidos mediante tecnologías frontend y Java Web.",
            "Trabajo de manera organizada por etapas: analizo el problema, planifico, diseño la interfaz, programo funcionalidades, realizo pruebas, corrijo errores y documento los resultados.",
            "Diseño UI/UX, desarrollo frontend, Java Web, experiencias responsive, organización de contenido, prototipado y mejora continua de aplicaciones.",
            "Creatividad, organización, aprendizaje continuo, atención al detalle, resolución de problemas, diseño de interfaces y programación web.",
            "Seguir desarrollando proyectos web cada vez más completos, usables y profesionales, integrando buenas prácticas de diseño, programación, accesibilidad y gestión de información.",
            "El curso permite integrar en un producto real los conocimientos adquiridos en la carrera: investigación del problema, diseño de experiencia de usuario, maquetación, programación, persistencia, administración, pruebas y presentación final."
        );
    }

    private AppData datosIniciales() {
        AppData d = new AppData();

        Usuario admin = new Usuario(
                "Noemi Capcha Advincula",
                "noemi@gmail.com",
                PasswordUtil.hash("12345678"),
                "ADMIN"
        );
        d.getUsuarios().put(admin.getUsuario(), admin);
        d.setPerfil(perfilInicial());

        String[] temas = {
            "Presentación del curso, propósito del proyecto, resultados esperados y organización del portafolio académico.",
            "Identificación del problema, análisis de necesidades, público objetivo, usuarios y requerimientos funcionales de la aplicación.",
            "Planificación del proyecto: objetivos, alcance, arquitectura general, estructura de contenidos, tareas y cronograma de desarrollo.",
            "Diseño de experiencia de usuario: arquitectura de información, navegación, flujo de pantallas, bocetos y wireframes.",
            "Diseño visual de la interfaz: paleta de colores, tipografía, composición, componentes, consistencia visual y accesibilidad.",
            "Maquetación con HTML5: estructura semántica, formularios, organización del contenido y buenas prácticas de código.",
            "Estilos con CSS3: layouts, componentes, diseño responsive, adaptación a computadora, tablet y dispositivos móviles.",
            "Interactividad con JavaScript: eventos, validaciones, navegación dinámica, manipulación del DOM y experiencia del usuario.",
            "Introducción a Java Web: estructura del proyecto, JSP, Servlets, peticiones HTTP y configuración con Apache Tomcat.",
            "Arquitectura MVC: organización del proyecto en controller, dao, model y util para separar responsabilidades.",
            "Persistencia y acceso a datos: DAO, modelos, almacenamiento, consultas y actualización de la información del sistema.",
            "Autenticación y sesiones: login, control de acceso, seguridad básica y protección del panel administrativo.",
            "Operaciones CRUD: crear, listar, editar y eliminar semanas, perfil y proyectos desde el panel de administración.",
            "Gestión de evidencias: carga, descarga, visualización y eliminación de archivos asociados a cada semana.",
            "Pruebas funcionales, validación responsive, corrección de errores, usabilidad, accesibilidad y mejora continua.",
            "Integración final, documentación técnica, exposición, demostración y presentación del Proyecto de aplicación profesional."
        };

        for (int i = 1; i <= temas.length; i++) {
            d.getSemanas().put(i, new Semana(i, "Semana " + i, temas[i - 1]));
        }

        d.getProyectos().add(new Proyecto(
                1,
                "Portafolio académico interactivo",
                "Aplicación web personal para presentar mi perfil, carrera, curso, proyectos y evidencias semanales en una interfaz responsive e interactiva.",
                "Java · JSP · CSS · JavaScript",
                "Portafolio web",
                "Integración de diseño visual, navegación dinámica, componentes responsive y organización académica del contenido."
        ));

        d.getProyectos().add(new Proyecto(
                2,
                "Panel administrativo",
                "Módulo protegido por login que permite administrar el contenido del portafolio desde una interfaz visual centralizada.",
                "Servlets · JSP · MVC · Sesiones",
                "Administración",
                "Uso de autenticación, control de acceso, formularios, sesiones y separación de responsabilidades mediante MVC."
        ));

        d.getProyectos().add(new Proyecto(
                3,
                "Gestión de semanas y evidencias",
                "Sistema CRUD para crear, editar y eliminar semanas, además de subir, descargar y retirar archivos de evidencia.",
                "Java Web · DAO · Multipart",
                "Gestión académica",
                "Manejo de datos persistentes, carga de archivos y administración del avance semanal."
        ));

        d.getProyectos().add(new Proyecto(
                4,
                "Interfaz responsive",
                "Diseño adaptable inspirado en una paleta pastel rosa y lila, optimizado para escritorio, tablet y celular.",
                "HTML5 · CSS3 · Responsive Design",
                "UI/UX",
                "Aplicación de jerarquía visual, componentes reutilizables, adaptación de layouts y experiencia de usuario."
        ));

        return d;
    }
}
