<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    HttpSession sessao = request.getSession(false);
    if (sessao != null && (sessao.getAttribute("user") != null)) {
        response.sendRedirect(request.getContextPath() + "/app/logged_in/menu.jsp");
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">    
    </head>
    <body>
        <div class="container">
            <h1>Login</h1>
            <br>
            <br>

            <%                System.out.println("=== LOGIN.JSP CARREGADO ===");
            %>

            <form action="${pageContext.request.contextPath}/app?task=login" method="POST">
                <div class="input-group">
                    <input type="text" id="user" name="user" placeholder=" " required maxlength="50">
                    <label for="user">Usuário</label>
                </div>

                <div class="input-group">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label for="password">Senha</label>
                </div>

                <button type="submit">Entrar</button>
            </form>

            <div class="register-link">
                Não tem conta? <a href="${pageContext.request.contextPath}/app?task=register">Registre-se aqui</a>
            </div>
        </div>
    </body>
</html>
