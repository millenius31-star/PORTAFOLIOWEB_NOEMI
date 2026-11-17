<%@ page import="model.Semana,model.ArchivoSemana,dao.SemanaDAO" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    Semana semana = new SemanaDAO().buscar(14);
    if (semana == null) { response.sendError(404); return; }
%>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Semana 14 | Portafolio Noemi</title>
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
        <div class="week-dialog-number">14</div>
        <div><span>SEMANA 14</span><h2><%=semana.getTitulo()%></h2><p><%=semana.getDescripcion()%></p></div>
      </div>
      <div class="week-dialog-role-grid">
        <section class="upload-role-card professor-role">
          <div class="role-title-row"><div class="role-icon">👩‍🏫</div><div><span>PROFESOR</span><h3>Material de clase</h3></div></div>
          <div class="role-file-list">
          <% boolean hp=false; for(ArchivoSemana a:semana.getArchivos()){ if("PROFESOR".equalsIgnoreCase(a.getTipo())){ hp=true; %>
            <div class="role-file-item evidence-item"><span>📄</span><span class="evidence-name"><%=a.getNombreOriginal()%></span><div class="evidence-actions"><a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>&amp;accion=ver" target="_blank" rel="noopener">👁 Ver</a><a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>&amp;accion=descargar">↓ Descargar</a></div></div>
          <% } } if(!hp){ %><div class="role-empty">Sin archivos del profesor.</div><% } %>
          </div>
        </section>
        <section class="upload-role-card student-role">
          <div class="role-title-row"><div class="role-icon">🎓</div><div><span>ALUMNO</span><h3>Mis evidencias</h3></div></div>
          <div class="role-file-list">
          <% boolean ha=false; for(ArchivoSemana a:semana.getArchivos()){ if("ALUMNO".equalsIgnoreCase(a.getTipo()) || "GENERAL".equalsIgnoreCase(a.getTipo())){ ha=true; %>
            <div class="role-file-item evidence-item"><span>📄</span><span class="evidence-name"><%=a.getNombreOriginal()%></span><div class="evidence-actions"><a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>&amp;accion=ver" target="_blank" rel="noopener">👁 Ver</a><a href="${pageContext.request.contextPath}/archivo?id=<%=a.getId()%>&amp;accion=descargar">↓ Descargar</a></div></div>
          <% } } if(!ha){ %><div class="role-empty">Sin evidencias del alumno.</div><% } %>
          </div>
        </section>
      </div>
    </article>
  </div>
</section>
</body>
</html>
