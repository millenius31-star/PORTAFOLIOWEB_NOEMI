<%@ page import="java.util.List,model.Proyecto,model.Perfil,dao.ProyectoDAO,dao.PerfilDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    List<Proyecto> proyectos = (List<Proyecto>) request.getAttribute("proyectos");
    if (proyectos == null) proyectos = new ProyectoDAO().listar();
    Perfil perfil = new PerfilDAO().obtener();
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Proyectos | <%=perfil.getNombre()%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body>
<nav class="nav">
    <div class="container nav-inner">
        <a class="brand" href="${pageContext.request.contextPath}/">noemi ♡</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Inicio</a>
            <a href="${pageContext.request.contextPath}/sobre-mi.jsp">Sobre mí</a>
            <a href="${pageContext.request.contextPath}/semanas">Semanas</a>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</nav>

<section class="section">
    <div class="container">
        <div class="section-head">
            <div>
                <h2>Mis proyectos</h2>
                <p class="section-sub">
                    Aplicaciones y módulos desarrollados en <%=perfil.getCurso()%> · <%=perfil.getCarrera()%>.
                </p>
            </div>
        </div>

        <div class="grid">
            <% if (proyectos.isEmpty()) { %>
                <article class="card">
                    <div class="icon">＋</div>
                    <h3>Aún no hay proyectos</h3>
                    <p>Agrega proyectos desde el panel de control.</p>
                </article>
            <% } else { for(Proyecto p: proyectos){ %>
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
                        <div class="project-learning"><b>Aprendizaje:</b> <%=p.getAprendizaje()%></div>
                    <% } %>
                </article>
            <% }} %>
        </div>
    </div>
</section>
</body>
</html>
