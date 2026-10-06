<%@ page import="java.util.List,model.Semana,model.ArchivoSemana,model.Proyecto,model.Perfil,dao.SemanaDAO,dao.ProyectoDAO,dao.PerfilDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Semana> semanas = (List<Semana>) request.getAttribute("semanas");
    if (semanas == null) semanas = new SemanaDAO().listar();

    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    if (proyectos == null) proyectos = new ProyectoDAO().listar();

    Perfil perfil = (Perfil) request.getAttribute("perfil");
    if (perfil == null) perfil = new PerfilDAO().obtener();

    int totalArchivos = 0;
    for (Semana s : semanas) totalArchivos += s.getArchivos().size();

    int totalProyectos = proyectos.size();
    int progreso = Math.min(100, Math.round((semanas.size() / 16.0f) * 100));
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Panel de control | Noemi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body class="admin-body">
<div class="admin-shell">
    <aside class="admin-sidebar" aria-label="Menú de administración">
        <div class="admin-profile">
            <div class="admin-avatar">NC</div>
            <div>
                <strong>Noemi</strong>
                <span>Administradora</span>
            </div>
        </div>

        <nav class="side-menu">
            <a class="side-link active" href="#inicio-panel"><span>⌂</span> Dashboard</a>
            <a class="side-link" href="#editar-sobre-mi"><span>✎</span> Sobre mí</a>
            <a class="side-link" href="#administrar-proyectos"><span>♡</span> Proyectos</a>
            <a class="side-link" href="#nueva-semana"><span>＋</span> Nueva semana</a>
            <a class="side-link" href="#administrar-semanas"><span>▦</span> Semanas</a>
            <a class="side-link" href="${pageContext.request.contextPath}/"><span>◉</span> Ver portafolio</a>
            <a class="side-link" href="${pageContext.request.contextPath}/logout"><span>↪</span> Cerrar sesión</a>
        </nav>

        <div class="side-course">
            <small>CURSO</small>
            <b><%=perfil.getCurso()%></b>
            <span><%=perfil.getCarrera()%></span>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-topbar">
            <div>
                <span class="admin-kicker">Panel de control</span>
                <h1>Dashboard</h1>
            </div>

            <div class="admin-top-actions">
                <label class="admin-search">
                    <span>⌕</span>
                    <input id="weekSearch" type="search" placeholder="Buscar semana o tema..." aria-label="Buscar semana">
                </label>
                <a class="top-round" href="${pageContext.request.contextPath}/" aria-label="Ver portafolio">♡</a>
                <div class="top-user" title="<%=perfil.getNombre()%>">NC</div>
            </div>
        </header>

        <section id="inicio-panel" class="dash-welcome">
            <div class="welcome-copy">
                <span class="welcome-pill">PORTAFOLIO ACADÉMICO</span>
                <h2>¡Bienvenida, Noemi!</h2>
                <p>
                    Desde este panel puedes administrar el contenido principal de tu portafolio:
                    <b>Sobre mí</b>, <b>Proyectos</b>, <b>Semanas</b> y <b>evidencias</b>.
                    El sistema está pensado para el curso <b><%=perfil.getCurso()%></b> de la carrera
                    <b><%=perfil.getCarrera()%></b>.
                </p>
                <div class="welcome-actions">
                    <a class="welcome-btn" href="#editar-sobre-mi">Editar perfil →</a>
                    <a class="welcome-btn soft" href="#administrar-proyectos">Gestionar proyectos</a>
                </div>
            </div>

            <div class="welcome-illustration" aria-hidden="true">
                <div class="mini-window"><span></span><span></span><span></span><b>&lt;/&gt;</b></div>
                <div class="mini-person">NC</div>
                <div class="mini-flower">✿</div>
            </div>
        </section>

        <section class="dash-stat-grid" aria-label="Resumen del portafolio">
            <article class="dash-stat peach">
                <div class="stat-icon">▦</div>
                <div><span>Semanas</span><strong><%=semanas.size()%></strong><small>organizadas en el curso</small></div>
            </article>

            <article class="dash-stat lavender">
                <div class="stat-icon">📎</div>
                <div><span>Evidencias</span><strong><%=totalArchivos%></strong><small>archivos cargados</small></div>
            </article>

            <article class="dash-stat mint">
                <div class="stat-icon">♡</div>
                <div><span>Proyectos</span><strong><%=totalProyectos%></strong><small>trabajos administrables</small></div>
            </article>
        </section>

        <section class="dash-two-col">
            <article class="dashboard-card progress-card">
                <div class="dashboard-card-head">
                    <div>
                        <span class="admin-kicker">AVANCE GENERAL</span>
                        <h2>Progreso del curso</h2>
                    </div>
                    <span class="progress-percent"><%=progreso%>%</span>
                </div>

                <p>
                    Seguimiento general basado en las 16 semanas del curso. Además del avance semanal,
                    ahora el panel permite mantener actualizado el perfil académico y los proyectos.
                </p>

                <div class="progress-track" aria-label="Progreso <%=progreso%> por ciento">
                    <span style="width:<%=progreso%>%"></span>
                </div>

                <div class="progress-meta">
                    <span><b><%=semanas.size()%></b> semanas registradas</span>
                    <span><b><%=totalArchivos%></b> evidencias</span>
                    <span><b><%=totalProyectos%></b> proyectos</span>
                </div>
            </article>

            <article id="nueva-semana" class="dashboard-card create-week-card">
                <div class="dashboard-card-head">
                    <div>
                        <span class="admin-kicker">NUEVO CONTENIDO</span>
                        <h2>Crear semana</h2>
                    </div>
                    <span class="round-plus">＋</span>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/semanas" class="compact-create-form">
                    <input type="hidden" name="accion" value="guardar">

                    <div class="form-inline-grid">
                        <label>
                            <span>Número</span>
                            <input class="input" type="number" min="1" name="numero" required placeholder="17">
                        </label>
                        <label>
                            <span>Título</span>
                            <input class="input" name="titulo" required placeholder="Semana 17">
                        </label>
                    </div>

                    <label>
                        <span>Descripción / tema</span>
                        <textarea class="textarea" name="descripcion" placeholder="Describe la actividad, tema o evidencia de la semana..."></textarea>
                    </label>

                    <button class="dashboard-primary" type="submit">Guardar semana</button>
                </form>
            </article>
        </section>

        <!-- EDITAR SOBRE MÍ -->
        <section id="editar-sobre-mi" class="dashboard-card admin-content-section">
            <div class="dashboard-card-head manager-head">
                <div>
                    <span class="admin-kicker">CONTENIDO PERSONAL</span>
                    <h2>Modificar “Sobre mí”</h2>
                    <p>
                        Cambia aquí la información que se mostrará en el portafolio.
                        Puedes actualizar tu presentación, carrera, objetivos, intereses, habilidades y visión profesional.
                    </p>
                </div>
                <span class="manager-count">Perfil</span>
            </div>

            <form method="post" action="${pageContext.request.contextPath}/perfil" class="profile-admin-form">
                <div class="form-inline-grid">
                    <label>
                        <span>Nombre completo</span>
                        <input class="input" name="nombre" value="<%=perfil.getNombre()%>" required>
                    </label>

                    <label>
                        <span>Carrera</span>
                        <input class="input" name="carrera" value="<%=perfil.getCarrera()%>" required>
                    </label>
                </div>

                <label>
                    <span>Curso</span>
                    <input class="input" name="curso" value="<%=perfil.getCurso()%>" required>
                </label>

                <label>
                    <span>Presentación personal</span>
                    <textarea class="textarea tall-textarea" name="presentacion"><%=perfil.getPresentacion()%></textarea>
                </label>

                <div class="profile-form-grid">
                    <label>
                        <span>Objetivo académico</span>
                        <textarea class="textarea" name="objetivo"><%=perfil.getObjetivo()%></textarea>
                    </label>

                    <label>
                        <span>Forma de trabajo</span>
                        <textarea class="textarea" name="formaTrabajo"><%=perfil.getFormaTrabajo()%></textarea>
                    </label>

                    <label>
                        <span>Intereses</span>
                        <textarea class="textarea" name="intereses"><%=perfil.getIntereses()%></textarea>
                    </label>

                    <label>
                        <span>Habilidades</span>
                        <textarea class="textarea" name="habilidades"><%=perfil.getHabilidades()%></textarea>
                    </label>

                    <label>
                        <span>Visión profesional</span>
                        <textarea class="textarea" name="vision"><%=perfil.getVision()%></textarea>
                    </label>

                    <label>
                        <span>Enfoque del proyecto</span>
                        <textarea class="textarea" name="enfoqueProyecto"><%=perfil.getEnfoqueProyecto()%></textarea>
                    </label>
                </div>

                <button class="dashboard-primary" type="submit">Guardar cambios de Sobre mí</button>
            </form>
        </section>

        <!-- PROYECTOS -->
        <section id="administrar-proyectos" class="dashboard-card admin-content-section">
            <div class="dashboard-card-head manager-head">
                <div>
                    <span class="admin-kicker">TRABAJOS DEL PORTAFOLIO</span>
                    <h2>Administrar proyectos</h2>
                    <p>
                        Agrega nuevos proyectos, modifica los existentes o elimina los que ya no quieras mostrar.
                        Cada proyecto puede incluir categoría, tecnologías y aprendizaje principal.
                    </p>
                </div>
                <span class="manager-count"><%=proyectos.size()%> proyectos</span>
            </div>

            <article class="project-create-box">
                <div class="mini-section-title">
                    <span class="round-plus">＋</span>
                    <div>
                        <h3>Agregar nuevo proyecto</h3>
                        <p>Crea una nueva tarjeta para la sección “Proyectos” del portafolio.</p>
                    </div>
                </div>

                <form method="post" action="${pageContext.request.contextPath}/proyectos" class="project-admin-form">
                    <input type="hidden" name="accion" value="guardar">
                    <input type="hidden" name="id" value="0">

                    <div class="form-inline-grid">
                        <label>
                            <span>Título</span>
                            <input class="input" name="titulo" required placeholder="Ej. Landing page responsive">
                        </label>

                        <label>
                            <span>Categoría</span>
                            <input class="input" name="categoria" placeholder="Ej. UI/UX, Java Web, Frontend">
                        </label>
                    </div>

                    <label>
                        <span>Descripción</span>
                        <textarea class="textarea" name="descripcion" placeholder="¿Qué hace el proyecto y qué problema resuelve?"></textarea>
                    </label>

                    <div class="form-inline-grid">
                        <label>
                            <span>Tecnologías</span>
                            <input class="input" name="tecnologia" placeholder="HTML · CSS · JavaScript">
                        </label>

                        <label>
                            <span>Aprendizaje principal</span>
                            <input class="input" name="aprendizaje" placeholder="¿Qué aprendiste con este proyecto?">
                        </label>
                    </div>

                    <button class="dashboard-primary" type="submit">Agregar proyecto</button>
                </form>
            </article>

            <div class="project-admin-list">
                <% for (Proyecto p : proyectos) { %>
                <article class="project-admin-card">
                    <div class="project-admin-head">
                        <div>
                            <span class="project-number">PROYECTO #<%=p.getId()%></span>
                            <h3><%=p.getTitulo()%></h3>
                        </div>

                        <form method="post" action="${pageContext.request.contextPath}/proyectos">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="id" value="<%=p.getId()%>">
                            <button class="icon-danger" type="submit"
                                    data-confirm="¿Eliminar este proyecto del portafolio?"
                                    aria-label="Eliminar proyecto <%=p.getTitulo()%>">×</button>
                        </form>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/proyectos" class="project-admin-form">
                        <input type="hidden" name="accion" value="guardar">
                        <input type="hidden" name="id" value="<%=p.getId()%>">

                        <div class="form-inline-grid">
                            <label>
                                <span>Título</span>
                                <input class="input" name="titulo" value="<%=p.getTitulo()%>" required>
                            </label>

                            <label>
                                <span>Categoría</span>
                                <input class="input" name="categoria" value="<%=p.getCategoria()%>">
                            </label>
                        </div>

                        <label>
                            <span>Descripción</span>
                            <textarea class="textarea" name="descripcion"><%=p.getDescripcion()%></textarea>
                        </label>

                        <div class="form-inline-grid">
                            <label>
                                <span>Tecnologías</span>
                                <input class="input" name="tecnologia" value="<%=p.getTecnologia()%>">
                            </label>

                            <label>
                                <span>Aprendizaje</span>
                                <input class="input" name="aprendizaje" value="<%=p.getAprendizaje()%>">
                            </label>
                        </div>

                        <button class="dashboard-secondary" type="submit">Guardar cambios</button>
                    </form>
                </article>
                <% } %>
            </div>
        </section>

        <!-- SEMANAS -->
        <section id="administrar-semanas" class="dashboard-card weeks-manager admin-content-section">
            <div class="dashboard-card-head manager-head">
                <div>
                    <span class="admin-kicker">GESTIÓN DEL CURSO</span>
                    <h2>Administrar semanas</h2>
                    <p>
                        Edita la información de cada semana, carga nuevas evidencias o elimina archivos.
                        Las semanas reflejan el proceso completo del Proyecto de aplicación profesional.
                    </p>
                </div>
                <span id="searchResult" class="manager-count"><%=semanas.size()%> semanas</span>
            </div>

            <div class="week-admin-v2" id="weekAdminList">
                <% for(Semana s : semanas){ %>
                <article class="week-admin-card"
                         data-week-card
                         data-search="semana <%=s.getNumero()%> <%=s.getTitulo()%> <%=s.getDescripcion()%>">

                    <div class="week-admin-banner">
                        <div class="week-badge"><%=s.getNumero()%></div>

                        <div class="week-admin-title">
                            <small>SEMANA <%=s.getNumero()%></small>
                            <h3><%=s.getTitulo()%></h3>
                        </div>

                        <form method="post" action="${pageContext.request.contextPath}/semanas">
                            <input type="hidden" name="accion" value="eliminar">
                            <input type="hidden" name="numero" value="<%=s.getNumero()%>">
                            <button class="icon-danger" type="submit"
                                    data-confirm="¿Eliminar esta semana y su información?"
                                    aria-label="Eliminar semana <%=s.getNumero()%>">×</button>
                        </form>
                    </div>

                    <form method="post" action="${pageContext.request.contextPath}/semanas" class="week-edit-form">
                        <input type="hidden" name="accion" value="guardar">
                        <input type="hidden" name="numero" value="<%=s.getNumero()%>">

                        <label>
                            <span>Título</span>
                            <input class="input" name="titulo" value="<%=s.getTitulo()%>" required>
                        </label>

                        <label>
                            <span>Descripción</span>
                            <textarea class="textarea" name="descripcion"><%=s.getDescripcion()%></textarea>
                        </label>

                        <button class="dashboard-secondary" type="submit">Guardar cambios</button>
                    </form>

                    <div class="file-management">
                        <div class="file-management-head">
                            <b>Evidencias de la semana</b>
                            <span><%=s.getArchivos().size()%> archivo(s)</span>
                        </div>

                        <div class="admin-role-upload-grid">
                            <form class="upload-line-v2 role-admin-upload professor-admin-upload"
                                  method="post"
                                  action="${pageContext.request.contextPath}/archivo"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="accion" value="subir">
                                <input type="hidden" name="origen" value="dashboard">
                                <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                                <input type="hidden" name="tipo" value="PROFESOR">

                                <div class="admin-upload-label">👩‍🏫 Archivo del profesor</div>
                                <label class="file-picker">
                                    <span>📎 Elegir uno o varios archivos</span>
                                    <input type="file" name="archivo" multiple required>
                                </label>
                                <small class="multi-file-note">Puedes seleccionar varios archivos a la vez.</small>
                                <button class="dashboard-primary small" type="submit">Subir archivos</button>
                            </form>

                            <form class="upload-line-v2 role-admin-upload student-admin-upload"
                                  method="post"
                                  action="${pageContext.request.contextPath}/archivo"
                                  enctype="multipart/form-data">
                                <input type="hidden" name="accion" value="subir">
                                <input type="hidden" name="origen" value="dashboard">
                                <input type="hidden" name="semana" value="<%=s.getNumero()%>">
                                <input type="hidden" name="tipo" value="ALUMNO">

                                <div class="admin-upload-label">🎓 Archivo del alumno</div>
                                <label class="file-picker">
                                    <span>📎 Elegir uno o varios archivos</span>
                                    <input type="file" name="archivo" multiple required>
                                </label>
                                <small class="multi-file-note">Puedes seleccionar varios archivos a la vez.</small>
                                <button class="dashboard-primary small" type="submit">Subir archivos</button>
                            </form>
                        </div>

                        <div class="admin-files">
                            <% if(s.getArchivos().isEmpty()){ %>
                                <div class="empty-evidence">Aún no hay archivos en esta semana.</div>
                            <% } else { for(ArchivoSemana a:s.getArchivos()){ %>
                                <div class="admin-file-row">
                                    <a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>">
                                        <span>📄</span><%=a.getNombreOriginal()%> <small class="file-type-badge"><%=a.getTipoEtiqueta()%></small>
                                    </a>

                                    <form method="post" action="${pageContext.request.contextPath}/archivo">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="id" value="<%=a.getId()%>">
                                        <button class="remove-file" type="submit"
                                                data-confirm="¿Quitar este archivo?">Quitar</button>
                                    </form>
                                </div>
                            <% }} %>
                        </div>
                    </div>
                </article>
                <% } %>
            </div>
        </section>
    </main>
</div>

<script src="${pageContext.request.contextPath}/assets/js/app.js?v=20260905-modal-position-fix"></script>
</body>
</html>
