<%@ page import="java.util.List,model.Semana,model.ArchivoSemana,model.Proyecto,model.Perfil,dao.SemanaDAO,dao.ProyectoDAO,dao.PerfilDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Semana> semanas = new SemanaDAO().listar();
    List<Proyecto> proyectos = new ProyectoDAO().listar();
    Perfil perfil = new PerfilDAO().obtener();
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Portafolio | <%=perfil.getNombre()%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body class="spa-body">
<nav class="nav" aria-label="Navegación principal">
    <div class="container nav-inner spa-nav-inner">
        <a class="brand" href="${pageContext.request.contextPath}/" aria-label="Portafolio de Noemi">noemi ♡</a>

        <div class="nav-links spa-nav" role="tablist" aria-label="Secciones del portafolio">
            <button type="button" class="nav-switch active" data-view="inicio" role="tab" aria-selected="true">Inicio</button>
            <button type="button" class="nav-switch" data-view="sobre-mi" role="tab" aria-selected="false">Sobre mí</button>
            <button type="button" class="nav-switch" data-view="proyectos" role="tab" aria-selected="false">Proyectos</button>
            <button type="button" class="nav-switch" data-view="semanas" role="tab" aria-selected="false">Semanas</button>
            <button type="button" class="nav-switch login-trigger" id="openLogin">Login</button>
        </div>
    </div>
</nav>

<div id="spaContent" class="spa-content">
    <!-- INICIO -->
    <div class="page-view is-active" data-page="inicio" role="tabpanel">
        <main class="hero">
            <div class="container hero-grid">
                <section>
                    <span class="eyebrow">♥ PORTAFOLIO ACADÉMICO</span>
                    <h1>Diseño ideas y las convierto en <em>experiencias web.</em></h1>

                    <p class="lead">
                        Soy <b><%=perfil.getNombre()%></b>, estudiante de la carrera de
                        <b><%=perfil.getCarrera()%></b>. Este portafolio reúne mi proceso de aprendizaje,
                        actividades, evidencias y proyectos desarrollados en el curso
                        <b><%=perfil.getCurso()%></b>.
                    </p>

                    <div class="actions">
                        <button type="button" class="btn view-trigger" data-view="semanas">Ver semanas →</button>
                        <button type="button" class="btn outline view-trigger" data-view="proyectos">Explorar proyectos</button>
                    </div>
                </section>

                <section class="hero-art noemi-main-art" aria-label="Ilustración principal del portafolio">
                    <img class="noemi-main-image"
                         src="${pageContext.request.contextPath}/assets/img/noemi-principal.png"
                         alt="Noemi Diseño y Programación Web">
                </section>
            </div>
        </main>

        <section class="section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <span class="eyebrow">♡ FORMACIÓN PROFESIONAL</span>
                        <h2>Mi carrera y el curso</h2>
                        <p class="section-sub">
                            El portafolio integra diseño visual, experiencia de usuario, programación,
                            gestión de información y presentación de evidencias.
                        </p>
                    </div>
                </div>

                <div class="course-grid">
                    <article class="card course-card">
                        <div class="icon">🎨</div>
                        <h3><%=perfil.getCarrera()%></h3>
                        <p>
                            La carrera combina diseño, creatividad y programación para crear productos digitales.
                            Incluye maquetación, interfaces responsive, experiencia de usuario, frontend,
                            backend y organización de contenidos.
                        </p>
                        <span class="tag">Carrera profesional</span>
                    </article>

                    <article class="card course-card">
                        <div class="icon">💻</div>
                        <h3><%=perfil.getCurso()%></h3>
                        <p>
                            Es un curso integrador donde se aplica lo aprendido en un proyecto real:
                            análisis de necesidades, diseño UI/UX, programación, almacenamiento de datos,
                            autenticación, pruebas y documentación.
                        </p>
                        <span class="tag">Curso integrador</span>
                    </article>

                    <article class="card course-card">
                        <div class="icon">🚀</div>
                        <h3>Producto profesional</h3>
                        <p>
                            El resultado final es una aplicación web organizada, funcional y responsive,
                            acompañada por evidencias semanales que demuestran el proceso de construcción,
                            revisión y mejora.
                        </p>
                        <span class="tag">Resultado esperado</span>
                    </article>
                </div>
            </div>
        </section>

        <section class="section compact-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <h2>¿Qué desarrollo durante el curso?</h2>
                        <p class="section-sub">
                            El proyecto se trabaja como un proceso completo, desde la idea inicial hasta la entrega final.
                        </p>
                    </div>
                </div>

                <div class="learning-grid">
                    <article class="learning-card">
                        <span>01</span><h3>Análisis del problema</h3>
                        <p>Identifico necesidades, usuarios, objetivos, alcance y requerimientos antes de diseñar la solución.</p>
                    </article>
                    <article class="learning-card">
                        <span>02</span><h3>Diseño UI/UX</h3>
                        <p>Organizo la navegación, wireframes, colores, tipografías, componentes y experiencia de uso.</p>
                    </article>
                    <article class="learning-card">
                        <span>03</span><h3>Frontend responsive</h3>
                        <p>Construyo interfaces con HTML, CSS y JavaScript adaptadas a diferentes tamaños de pantalla.</p>
                    </article>
                    <article class="learning-card">
                        <span>04</span><h3>Java Web</h3>
                        <p>Trabajo con JSP, Servlets, sesiones y arquitectura MVC para implementar la lógica del sistema.</p>
                    </article>
                    <article class="learning-card">
                        <span>05</span><h3>Gestión de datos</h3>
                        <p>Implemento operaciones CRUD, DAO, persistencia y administración de contenidos y archivos.</p>
                    </article>
                    <article class="learning-card">
                        <span>06</span><h3>Pruebas y presentación</h3>
                        <p>Valido la funcionalidad, corrijo errores, documento evidencias y preparo la demostración final.</p>
                    </article>
                </div>
            </div>
        </section>

        <section class="section compact-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <h2>Ruta de desarrollo del proyecto</h2>
                        <p class="section-sub">Una metodología ordenada para convertir una idea en una aplicación funcional.</p>
                    </div>
                </div>

                <div class="process-strip">
                    <div><b>1</b><span>Investigar</span></div>
                    <i>→</i>
                    <div><b>2</b><span>Planificar</span></div>
                    <i>→</i>
                    <div><b>3</b><span>Diseñar</span></div>
                    <i>→</i>
                    <div><b>4</b><span>Programar</span></div>
                    <i>→</i>
                    <div><b>5</b><span>Probar</span></div>
                    <i>→</i>
                    <div><b>6</b><span>Presentar</span></div>
                </div>
            </div>
        </section>

        <section class="section compact-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <h2>Tecnologías y herramientas</h2>
                        <p class="section-sub">Herramientas utilizadas para diseñar, programar y organizar el proyecto.</p>
                    </div>
                </div>

                <div class="tech-panel">
                    <span>HTML5</span>
                    <span>CSS3</span>
                    <span>JavaScript</span>
                    <span>Java</span>
                    <span>JSP</span>
                    <span>Servlets</span>
                    <span>MVC</span>
                    <span>DAO</span>
                    <span>Apache Tomcat</span>
                    <span>NetBeans</span>
                    <span>Responsive Design</span>
                    <span>Git / documentación</span>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <h2>Competencias que desarrollo</h2>
                        <p class="section-sub">
                            El curso integra conocimientos técnicos, visuales y de gestión.
                        </p>
                    </div>
                </div>

                <div class="skill-grid">
                    <article class="skill-item">
                        <span>01</span>
                        <div><b>Diseño de interfaces</b><p>Jerarquía visual, composición, tipografía, color, accesibilidad y experiencia de usuario.</p></div>
                    </article>

                    <article class="skill-item">
                        <span>02</span>
                        <div><b>Desarrollo frontend</b><p>HTML, CSS, diseño responsive, JavaScript y manipulación dinámica de la interfaz.</p></div>
                    </article>

                    <article class="skill-item">
                        <span>03</span>
                        <div><b>Desarrollo Java Web</b><p>JSP, Servlets, sesiones, arquitectura MVC, DAO y gestión de datos.</p></div>
                    </article>

                    <article class="skill-item">
                        <span>04</span>
                        <div><b>Gestión del proyecto</b><p>Planificación por semanas, evidencias, pruebas, correcciones y presentación del producto.</p></div>
                    </article>
                </div>
            </div>
        </section>

        <section class="section">
            <div class="container banner">
                <div>
                    <strong><%=perfil.getCurso()%></strong>
                    <p class="section-sub">
                        Proyecto académico de <%=perfil.getCarrera()%> con administración de perfil,
                        proyectos, semanas y archivos de evidencia.
                    </p>
                </div>
                <button type="button" class="btn login-trigger">Administrar portafolio</button>
            </div>
        </section>
    </div>

    <!-- SOBRE MÍ -->
    <div class="page-view" data-page="sobre-mi" role="tabpanel" hidden>
        <section class="section view-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <span class="eyebrow">♡ CONÓCEME</span>
                        <h2>Sobre mí</h2>
                        <p class="section-sub">Mi perfil dentro de la carrera de <%=perfil.getCarrera()%>.</p>
                    </div>
                </div>

                <div class="about-layout">
                    <article class="card about-main">
                        <div class="profile-badge">NC</div>
                        <div>
                            <h3><%=perfil.getNombre()%></h3>
                            <p><%=perfil.getPresentacion()%></p>
                        </div>
                    </article>

                    <article class="card">
                        <div class="icon">🎯</div>
                        <h3>Objetivo académico</h3>
                        <p><%=perfil.getObjetivo()%></p>
                    </article>

                    <article class="card">
                        <div class="icon">🧠</div>
                        <h3>Forma de trabajo</h3>
                        <p><%=perfil.getFormaTrabajo()%></p>
                    </article>
                </div>

                <div class="section-head secondary-head">
                    <div>
                        <h2>Mi perfil profesional en formación</h2>
                        <p class="section-sub">Aspectos que orientan mi desarrollo en Diseño y Programación Web.</p>
                    </div>
                </div>

                <div class="grid profile-info-grid">
                    <article class="card">
                        <div class="icon">💗</div>
                        <h3>Intereses</h3>
                        <p><%=perfil.getIntereses()%></p>
                    </article>

                    <article class="card">
                        <div class="icon">✨</div>
                        <h3>Habilidades</h3>
                        <p><%=perfil.getHabilidades()%></p>
                    </article>

                    <article class="card">
                        <div class="icon">🌱</div>
                        <h3>Visión profesional</h3>
                        <p><%=perfil.getVision()%></p>
                    </article>
                </div>

                <div class="learning-note">
                    <b>Relación con el curso:</b> <%=perfil.getEnfoqueProyecto()%>
                </div>
            </div>
        </section>
    </div>

    <!-- PROYECTOS -->
    <div class="page-view" data-page="proyectos" role="tabpanel" hidden>
        <section class="section view-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <span class="eyebrow">♡ TRABAJOS</span>
                        <h2>Mis proyectos</h2>
                        <p class="section-sub">
                            Soluciones desarrolladas para aplicar conocimientos de <%=perfil.getCarrera()%>.
                        </p>
                    </div>
                </div>

                <div class="project-intro card">
                    <div>
                        <h3>Del diseño a una aplicación funcional</h3>
                        <p>
                            Los proyectos documentan diferentes partes del proceso de desarrollo:
                            interfaz, programación, administración, persistencia, evidencias y experiencia responsive.
                            Cada tarjeta muestra las tecnologías usadas y el aprendizaje obtenido.
                        </p>
                    </div>

                    <div class="project-flow" aria-label="Proceso de desarrollo">
                        <span>Analizar</span><b>→</b><span>Diseñar</span><b>→</b>
                        <span>Programar</span><b>→</b><span>Probar</span><b>→</b><span>Mejorar</span>
                    </div>
                </div>

                <div class="grid project-list">
                    <% if (proyectos.isEmpty()) { %>
                        <article class="card empty-project-card">
                            <div class="icon">＋</div>
                            <h3>Aún no hay proyectos</h3>
                            <p>Los proyectos que agregues desde el panel de control aparecerán aquí automáticamente.</p>
                        </article>
                    <% } else { for (Proyecto p : proyectos) { %>
                        <article class="card project-card">
                            <div class="project-card-top">
                                <div class="icon">♡</div>
                                <span class="tag"><%=p.getCategoria()%></span>
                            </div>
                            <h3><%=p.getTitulo()%></h3>
                            <p><%=p.getDescripcion()%></p>
                            <div class="project-detail">
                                <b>Tecnologías</b>
                                <span><%=p.getTecnologia()%></span>
                            </div>
                            <% if (p.getAprendizaje() != null && !p.getAprendizaje().isBlank()) { %>
                            <div class="project-learning">
                                <b>Aprendizaje:</b> <%=p.getAprendizaje()%>
                            </div>
                            <% } %>
                        </article>
                    <% }} %>
                </div>
            </div>
        </section>
    </div>

    <!-- SEMANAS -->
    <div class="page-view" data-page="semanas" role="tabpanel" hidden>
        <section class="section view-section">
            <div class="container">
                <div class="section-head">
                    <div>
                        <span class="eyebrow">♡ EVIDENCIAS</span>
                        <h2>Semanas del curso</h2>
                        <p class="section-sub">
                            Registro del avance semanal de <%=perfil.getCurso()%>.
                            Cada semana documenta una etapa del proceso de diseño y desarrollo.
                        </p>
                    </div>
                </div>

                <div class="week-note learning-note">
                    <b>¿Qué encontrarás aquí?</b>
                    Planificación, diseño UI/UX, frontend, Java Web, arquitectura MVC, autenticación,
                    operaciones CRUD, archivos, pruebas y presentación final. Cuando una semana tiene evidencias,
                    los archivos pueden descargarse directamente desde su tarjeta.
                </div>

                <div class="week-grid week-grid-interactive ornate-week-grid">
                    <% for(Semana s : semanas){
                        int archivosProfesor = 0;
                        int archivosAlumno = 0;
                        for (ArchivoSemana a : s.getArchivos()) {
                            if ("PROFESOR".equalsIgnoreCase(a.getTipo())) archivosProfesor++;
                            else if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) archivosAlumno++;
                        }
                    %>
                    <article class="week-card-clickable ornate-week-card"
                             tabindex="0"
                             role="button"
                             aria-haspopup="dialog"
                             aria-controls="weekModal-<%=s.getNumero()%>"
                             data-week-open="weekModal-<%=s.getNumero()%>">
                        <div class="ornate-week-inner">
                            <div class="ornate-week-top">
                                <span class="ornate-week-pill">Semana <%=s.getNumero()%></span>
                                <span class="ornate-week-mark">❧</span>
                            </div>

                            <h3><%=s.getTitulo()%></h3>
                            <p class="ornate-week-description">Haz clic para revisar las indicaciones y todos los archivos publicados.</p>

                            <div class="ornate-week-code">Semana_<%=String.format("%02d", s.getNumero())%></div>

                            <div class="ornate-week-counts">
                                <span><b><%=archivosProfesor%></b> archivos del profesor</span>
                                <span><b><%=archivosAlumno%></b> evidencias del alumno</span>
                            </div>

                            <div class="ornate-week-status">＋ Abrir contenido</div>
                        </div>
                    </article>
                    <% } %>
                </div>

                <% for(Semana s : semanas){
                    int modalProfesor = 0;
                    int modalAlumno = 0;
                    for (ArchivoSemana a : s.getArchivos()) {
                        if ("PROFESOR".equalsIgnoreCase(a.getTipo())) modalProfesor++;
                        else if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) modalAlumno++;
                    }
                %>
                <div class="week-upload-overlay" id="weekModal-<%=s.getNumero()%>" hidden aria-hidden="true">
                    <section class="ornate-dialog-shell" role="dialog" aria-modal="true" aria-labelledby="weekModalTitle-<%=s.getNumero()%>">
                    <div class="ornate-dialog-frame">
                        <button class="ornate-dialog-close" type="button" data-week-close aria-label="Cerrar">×</button>

                        <div class="ornate-dialog-content">
                            <div class="ornate-public-pill">✦ Contenido de la semana</div>

                            <h2 id="weekModalTitle-<%=s.getNumero()%>">Semana <%=s.getNumero()%>: <%=s.getTitulo()%></h2>
                            <p class="ornate-dialog-date">Material y evidencias organizadas para esta semana.</p>

                            <section class="ornate-instructions">
                                <h3>Indicaciones, tarea o resumen de la clase</h3>
                                <p><%=s.getDescripcion()%></p>
                            </section>

                            <div class="ornate-upload-grid">
                                <section class="ornate-upload-box teacher-upload-box">
                                    <div class="ornate-upload-heading">
                                        <h3>Archivos del profesor</h3>
                                        <span class="ornate-count"><%=modalProfesor%></span>
                                    </div>
                                    <p class="ornate-upload-help">Guías, separatas, diapositivas, instrucciones, PDF, Word u otros materiales.</p>

                                    <form class="ornate-upload-form" method="post"
                                          action="${pageContext.request.contextPath}/archivo"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="accion" value="subir">
                                        <input type="hidden" name="origen" value="portafolio">
                                        <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                                        <input type="hidden" name="tipo" value="PROFESOR">

                                        <label class="ornate-file-picker">
                                            <span>📎 Seleccionar archivos del profesor</span>
                                            <small>Puedes elegir uno o varios archivos a la vez</small>
                                            <input type="file" name="archivo" multiple required>
                                        </label>
                                        <button class="ornate-upload-btn" type="submit">Subir archivos del profesor</button>
                                    </form>

                                    <div class="ornate-file-list">
                                        <% boolean modalHayProfesor = false;
                                           for (ArchivoSemana a : s.getArchivos()) {
                                               if ("PROFESOR".equalsIgnoreCase(a.getTipo())) { modalHayProfesor = true; %>
                                            <a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>" class="ornate-file-row">
                                                <span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b>
                                            </a>
                                        <%     }
                                           }
                                           if (!modalHayProfesor) { %>
                                            <div class="ornate-empty">Aún no hay archivos publicados por el profesor.</div>
                                        <% } %>
                                    </div>
                                </section>

                                <section class="ornate-upload-box student-upload-box">
                                    <div class="ornate-upload-heading">
                                        <h3>Archivos del alumno</h3>
                                        <span class="ornate-count"><%=modalAlumno%></span>
                                    </div>
                                    <p class="ornate-upload-help">Tareas, prácticas, capturas, documentos y productos desarrollados por el alumno.</p>

                                    <form class="ornate-upload-form" method="post"
                                          action="${pageContext.request.contextPath}/archivo"
                                          enctype="multipart/form-data">
                                        <input type="hidden" name="accion" value="subir">
                                        <input type="hidden" name="origen" value="portafolio">
                                        <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                                        <input type="hidden" name="tipo" value="ALUMNO">

                                        <label class="ornate-file-picker student-picker">
                                            <span>🎓 Seleccionar archivos del alumno</span>
                                            <small>Puedes elegir uno o varios archivos a la vez</small>
                                            <input type="file" name="archivo" multiple required>
                                        </label>
                                        <button class="ornate-upload-btn student-upload-btn" type="submit">Subir evidencias del alumno</button>
                                    </form>

                                    <div class="ornate-file-list">
                                        <% boolean modalHayAlumno = false;
                                           for (ArchivoSemana a : s.getArchivos()) {
                                               if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) { modalHayAlumno = true; %>
                                            <a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>" class="ornate-file-row">
                                                <span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b>
                                            </a>
                                        <%     }
                                           }
                                           if (!modalHayAlumno) { %>
                                            <div class="ornate-empty">Aún no hay evidencias publicadas por el alumno.</div>
                                        <% } %>
                                    </div>
                                </section>
                            </div>

                            <div class="ornate-dialog-footer">
                                <button type="button" class="ornate-close-secondary" data-week-close>Cerrar</button>
                                <span>Los archivos se guardan separados por semana, profesor y alumno.</span>
                            </div>
                        </div>
                    </div>
                    </section>
                </div>
                <% } %>
            </div>
        </section>
    </div>
</div>

<!-- LOGIN MODAL FUNCIONAL -->
<dialog class="login-dialog login-dialog-v2" id="loginModal">
    <div class="login-card-v2 modal-login-card">
        <button class="modal-x" id="closeLogin" type="button" aria-label="Cerrar">×</button>

        <div class="login-art">
            <img src="${pageContext.request.contextPath}/assets/img/login-ilustracion.png"
                 alt="Ilustración de acceso al portafolio">
        </div>

        <div class="login-panel">
            <h2>Welcome Back!</h2>
            <p>Login to continue</p>

            <form class="login-form-v2" method="post" action="${pageContext.request.contextPath}/login">
                <label class="login-input-wrap">
                    <span class="login-field-icon">👤</span>
                    <input name="usuario" type="email" value="noemi@gmail.com"
                           placeholder="Username / Email" autocomplete="username" required>
                </label>

                <label class="login-input-wrap">
                    <span class="login-field-icon">🔒</span>
                    <input id="modalPassword" name="password" type="password"
                           placeholder="Password" autocomplete="current-password" required>
                    <button type="button" class="password-toggle"
                            data-password-toggle="modalPassword" aria-label="Mostrar contraseña">◉</button>
                </label>

                <div class="login-help">Contraseña de administrador</div>
                <button class="login-gradient-btn" type="submit">Login</button>
            </form>

            <div class="social-divider"><span>or continue with</span></div>
            <div class="social-login-row" aria-label="Opciones visuales">
                <button class="social-demo google" type="button" data-provider="Google">G</button>
                <button class="social-demo apple" type="button" data-provider="Apple">●</button>
                <button class="social-demo facebook" type="button" data-provider="Facebook">f</button>
            </div>

            <p class="login-bottom-note">Administración del portafolio académico</p>
            <div class="social-message" id="socialMessage" aria-live="polite"></div>
        </div>
    </div>
</dialog>

<script src="${pageContext.request.contextPath}/assets/js/app.js?v=20260905-modal-position-fix"></script>
</body>
</html>
