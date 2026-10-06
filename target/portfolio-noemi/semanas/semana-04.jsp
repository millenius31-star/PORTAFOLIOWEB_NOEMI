<%@ page import="model.Semana,model.ArchivoSemana,dao.SemanaDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Semana semana = new SemanaDAO().buscar(4);
    if (semana == null) { response.sendError(404); return; }
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Semana 04 | Portafolio Noemi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body>
<nav class="nav">
    <div class="container nav-inner">
        <a class="brand" href="${pageContext.request.contextPath}/">noemi ♡</a>
        <div class="nav-links"><a href="${pageContext.request.contextPath}/?view=semanas">Volver a semanas</a></div>
    </div>
</nav>
<section class="section">
  <div class="container">
    <article class="card week-standalone-card">
      <div class="week-dialog-header">
        <div class="week-dialog-number">4</div>
        <div><span>SEMANA 4</span><h2><%=semana.getTitulo()%></h2><p><%=semana.getDescripcion()%></p></div>
      </div>
      <div class="week-dialog-role-grid">
        <section class="upload-role-card professor-role">
          <div class="role-title-row"><div class="role-icon">👩‍🏫</div><div><span>PROFESOR</span><h3>Material de clase</h3></div></div>
          <form class="role-upload-form" method="post" action="${pageContext.request.contextPath}/archivo" enctype="multipart/form-data">
            <input type="hidden" name="accion" value="subir"><input type="hidden" name="origen" value="portafolio">
            <input type="hidden" name="semana" value="4"><input type="hidden" name="tipo" value="PROFESOR">
            <label class="role-file-picker"><span>📎 Seleccionar uno o varios archivos del profesor</span><input type="file" name="archivo" multiple required></label>
            <small class="multi-file-note">Puedes seleccionar varios archivos a la vez.</small>
            <button class="role-upload-button professor-button" type="submit">Subir archivos</button>
          </form>
          <div class="role-file-list">
          <% boolean hp=false; for(ArchivoSemana a:semana.getArchivos()){ if("PROFESOR".equalsIgnoreCase(a.getTipo())){ hp=true; %>
            <a class="role-file-item" href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>"><span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b></a>
          <% } } if(!hp){ %><div class="role-empty">Sin archivos del profesor.</div><% } %>
          </div>
        </section>
        <section class="upload-role-card student-role">
          <div class="role-title-row"><div class="role-icon">🎓</div><div><span>ALUMNO</span><h3>Mis evidencias</h3></div></div>
          <form class="role-upload-form" method="post" action="${pageContext.request.contextPath}/archivo" enctype="multipart/form-data">
            <input type="hidden" name="accion" value="subir"><input type="hidden" name="origen" value="portafolio">
            <input type="hidden" name="semana" value="4"><input type="hidden" name="tipo" value="ALUMNO">
            <label class="role-file-picker"><span>📎 Seleccionar uno o varios archivos del alumno</span><input type="file" name="archivo" multiple required></label>
            <small class="multi-file-note">Puedes seleccionar varios archivos a la vez.</small>
            <button class="role-upload-button student-button" type="submit">Subir evidencias</button>
          </form>
          <div class="role-file-list">
          <% boolean ha=false; for(ArchivoSemana a:semana.getArchivos()){ if("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())){ ha=true; %>
            <a class="role-file-item" href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>"><span>📄</span><span><%=a.getNombreOriginal()%></span><b>↓</b></a>
          <% } } if(!ha){ %><div class="role-empty">Sin evidencias del alumno.</div><% } %>
          </div>
        </section>
      </div>
    </article>
  </div>
</section>
</body>
</html>
