<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!doctype html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <title>Login | Portafolio Noemi</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css?v=20260905-modal-position-fix">
</head>
<body class="login-page">
<main class="login-screen">
    <section class="login-card-v2" aria-labelledby="loginTitle">
        <a class="login-back" href="${pageContext.request.contextPath}/" aria-label="Volver al portafolio">←</a>
        <div class="login-art" aria-hidden="true">
            <img src="${pageContext.request.contextPath}/assets/img/login-ilustracion.png" alt="">
        </div>
        <div class="login-panel">
            <h1 id="loginTitle">Welcome Back!</h1>
            <p>Login to continue</p>

            <% if(request.getAttribute("error") != null){ %>
                <div class="login-message error"><%=request.getAttribute("error")%></div>
            <% } %>
            <% if(request.getAttribute("ok") != null){ %>
                <div class="login-message ok"><%=request.getAttribute("ok")%></div>
            <% } %>

            <form method="post" action="${pageContext.request.contextPath}/login" class="login-form-v2">
                <label class="login-input-wrap">
                    <span class="login-field-icon">👤</span>
                    <input type="email" name="usuario" required autocomplete="username" placeholder="Correo electrónico" value="noemi@gmail.com">
                </label>
                <label class="login-input-wrap">
                    <span class="login-field-icon">🔒</span>
                    <input id="loginPasswordPage" type="password" name="password" required autocomplete="current-password" placeholder="Contraseña">
                    <button class="password-toggle" type="button" data-password-toggle="loginPasswordPage" aria-label="Mostrar u ocultar contraseña">◉</button>
                </label>
                <div class="login-help-row">
                    <span>Acceso administrativo</span>
                    <span class="login-hint">Proyecto de aplicación profesional</span>
                </div>
                <button class="login-gradient-btn" type="submit">Login</button>
            </form>

            <div class="login-divider"><span>or continue with</span></div>
            <div class="social-login" aria-label="Opciones visuales de acceso">
                <button type="button" class="social-btn social-demo" data-provider="Google" aria-label="Continuar con Google">G</button>
                <button type="button" class="social-btn social-demo" data-provider="Apple" aria-label="Continuar con Apple">●</button>
                <button type="button" class="social-btn social-demo" data-provider="Facebook" aria-label="Continuar con Facebook">f</button>
            </div>
            <p id="socialMessage" class="social-message" aria-live="polite"></p>
            <div class="credential-box">
                <b>Cuenta de administración</b>
                <span>Correo: noemi@gmail.com</span>
                <span>Contraseña: 12345678</span>
            </div>
        </div>
    </section>
</main>
<script src="${pageContext.request.contextPath}/assets/js/app.js?v=20260905-modal-position-fix"></script>
</body>
</html>
