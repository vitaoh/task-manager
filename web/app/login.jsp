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
            <%                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <div style="color: #dc3545; background-color: rgba(220, 53, 69, 0.1); padding: 10px; border-radius: 5px; margin-bottom: 15px; border-left: 4px solid #dc3545;">
                <%= msg%>
            </div>
            <% } %>

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
                Não tem conta? <a href="${pageContext.request.contextPath}/app/register.jsp">Registre-se aqui</a>
            </div>
        </div>
    </body>
</html>
