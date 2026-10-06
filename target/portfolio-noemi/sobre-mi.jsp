<%@ page import="model.Perfil,dao.PerfilDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% Perfil perfil = new PerfilDAO().obtener(); %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Sobre mí | <%=perfil.getNombre()%></title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body>
<nav class="nav">
    <div class="container nav-inner">
        <a class="brand" href="${pageContext.request.contextPath}/">noemi ♡</a>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">Inicio</a>
            <a href="${pageContext.request.contextPath}/proyectos">Proyectos</a>
            <a href="${pageContext.request.contextPath}/semanas">Semanas</a>
            <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>
</nav>

<section class="section">
    <div class="container">
        <div class="section-head">
            <div>
                <h2>Sobre mí</h2>
                <p class="section-sub"><%=perfil.getCarrera()%> · <%=perfil.getCurso()%>.</p>
            </div>
        </div>

        <div class="grid">
            <div class="card" style="grid-column:span 2">
                <div class="icon">🌷</div>
                <h3><%=perfil.getNombre()%></h3>
                <p><%=perfil.getPresentacion()%></p>
            </div>

            <div class="card">
                <div class="icon">🎯</div>
                <h3>Objetivo</h3>
                <p><%=perfil.getObjetivo()%></p>
            </div>

            <div class="card">
                <div class="icon">🧠</div>
                <h3>Forma de trabajo</h3>
                <p><%=perfil.getFormaTrabajo()%></p>
            </div>

            <div class="card">
                <div class="icon">💗</div>
                <h3>Intereses</h3>
                <p><%=perfil.getIntereses()%></p>
            </div>

            <div class="card">
                <div class="icon">✨</div>
                <h3>Habilidades</h3>
                <p><%=perfil.getHabilidades()%></p>
            </div>
        </div>
    </div>
</section>
</body>
</html>
