<%@ page import="java.util.List,model.Semana,model.ArchivoSemana,dao.SemanaDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Semana> semanas = (List<Semana>) request.getAttribute("semanas");
    if (semanas == null) semanas = new SemanaDAO().listar();
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Semanas | Portafolio Noemi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body>
<nav class="nav">
    <div class="container nav-inner">
        <a class="brand" href="${pageContext.request.contextPath}/">noemi ♡</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Inicio</a>
            <a href="${pageContext.request.contextPath}/sobre-mi.jsp">Sobre mí</a>
            <a href="${pageContext.request.contextPath}/proyectos">Proyectos</a>
            <a class="active" href="${pageContext.request.contextPath}/semanas">Semanas</a>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</nav>

<section class="section">
    <div class="container">
        <div class="section-head">
            <div>
                <span class="eyebrow">♡ REGISTRO SEMANAL</span>
                <h2>Tarjetas de semanas</h2>
                <p class="section-sub">
                    Haz clic en cualquier semana. Se abrirá un cuadro emergente con indicaciones,
                    archivos del profesor y evidencias del alumno.
                </p>
            </div>
        </div>

        <div class="week-grid week-grid-interactive ornate-week-grid">
        <% for (Semana s : semanas) {
            int profesor = 0;
            int alumno = 0;
            for (ArchivoSemana a : s.getArchivos()) {
                if ("PROFESOR".equalsIgnoreCase(a.getTipo())) profesor++;
                else if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) alumno++;
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
                    <p class="ornate-week-description">
                        Haz clic para revisar las indicaciones y todos los archivos publicados.
                    </p>
                    <div class="ornate-week-code">Semana_<%=String.format("%02d", s.getNumero())%></div>
                    <div class="ornate-week-counts">
                        <span><b><%=profesor%></b> archivos del profesor</span>
                        <span><b><%=alumno%></b> evidencias del alumno</span>
                    </div>
                    <div class="ornate-week-status">＋ Abrir contenido</div>
                </div>
            </article>
        <% } %>
        </div>
    </div>
</section>

<% for (Semana s : semanas) {
    int profesor = 0;
    int alumno = 0;
    for (ArchivoSemana a : s.getArchivos()) {
        if ("PROFESOR".equalsIgnoreCase(a.getTipo())) profesor++;
        else if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) alumno++;
    }
%>
<div class="week-upload-overlay" id="weekModal-<%=s.getNumero()%>" hidden aria-hidden="true">
    <section class="ornate-dialog-shell" role="dialog" aria-modal="true"
             aria-labelledby="weekModalTitle-<%=s.getNumero()%>">
        <div class="ornate-dialog-frame">
            <button class="ornate-dialog-close" type="button" data-week-close aria-label="Cerrar">×</button>

            <div class="ornate-dialog-content">
                <div class="ornate-public-pill">✦ Contenido de la semana</div>
                <h2 id="weekModalTitle-<%=s.getNumero()%>">
                    Semana <%=s.getNumero()%>: <%=s.getTitulo()%>
                </h2>
                <p class="ornate-dialog-date">Material y evidencias organizadas para esta semana.</p>

                <section class="ornate-instructions">
                    <h3>Indicaciones, tarea o resumen de la clase</h3>
                    <p><%=s.getDescripcion()%></p>
                </section>

                <div class="ornate-upload-grid">
                    <section class="ornate-upload-box teacher-upload-box">
                        <div class="ornate-upload-heading">
                            <h3>Archivos del profesor</h3>
                            <span class="ornate-count"><%=profesor%></span>
                        </div>
                        <p class="ornate-upload-help">
                            Guías, separatas, diapositivas, instrucciones, PDF, Word y otros materiales.
                        </p>

                        <form class="ornate-upload-form" method="post"
                              action="${pageContext.request.contextPath}/archivo"
                              enctype="multipart/form-data">
                            <input type="hidden" name="accion" value="subir">
                            <input type="hidden" name="origen" value="portafolio">
                            <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                            <input type="hidden" name="tipo" value="PROFESOR">

                            <label class="ornate-file-picker">
                                <span>📎 Seleccionar archivos del profesor</span>
                                <small>Puedes elegir uno o varios archivos a la vez.</small>
                                <input type="file" name="archivo" multiple required>
                            </label>
                            <button class="ornate-upload-btn" type="submit">Subir archivos del profesor</button>
                        </form>

                        <div class="ornate-file-list">
                        <% boolean hayProfesor = false;
                           for (ArchivoSemana a : s.getArchivos()) {
                               if ("PROFESOR".equalsIgnoreCase(a.getTipo())) {
                                   hayProfesor = true; %>
                            <a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>" class="ornate-file-row">
                                <span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b>
                            </a>
                        <%     }
                           }
                           if (!hayProfesor) { %>
                            <div class="ornate-empty">Aún no hay archivos publicados por el profesor.</div>
                        <% } %>
                        </div>
                    </section>

                    <section class="ornate-upload-box student-upload-box">
                        <div class="ornate-upload-heading">
                            <h3>Archivos del alumno</h3>
                            <span class="ornate-count"><%=alumno%></span>
                        </div>
                        <p class="ornate-upload-help">
                            Tareas, prácticas, capturas, documentos y evidencias desarrolladas por el alumno.
                        </p>

                        <form class="ornate-upload-form" method="post"
                              action="${pageContext.request.contextPath}/archivo"
                              enctype="multipart/form-data">
                            <input type="hidden" name="accion" value="subir">
                            <input type="hidden" name="origen" value="portafolio">
                            <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                            <input type="hidden" name="tipo" value="ALUMNO">

                            <label class="ornate-file-picker student-picker">
                                <span>🎓 Seleccionar archivos del alumno</span>
                                <small>Puedes elegir uno o varios archivos a la vez.</small>
                                <input type="file" name="archivo" multiple required>
                            </label>
                            <button class="ornate-upload-btn student-upload-btn" type="submit">
                                Subir evidencias del alumno
                            </button>
                        </form>

                        <div class="ornate-file-list">
                        <% boolean hayAlumno = false;
                           for (ArchivoSemana a : s.getArchivos()) {
                               if ("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())) {
                                   hayAlumno = true; %>
                            <a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>" class="ornate-file-row">
                                <span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b>
                            </a>
                        <%     }
                           }
                           if (!hayAlumno) { %>
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

<script src="${pageContext.request.contextPath}/assets/js/app.js?v=20260905-modal-position-fix"></script>
</body>
</html>
