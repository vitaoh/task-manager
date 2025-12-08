<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Registrar | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">    
    </head>
    <body>
        <div class="container">
            <h1>Registrar</h1>
            <h2>Crie sua conta</h2>

            <br>

            <%
                String msg = (String) request.getAttribute("msg");
                if (msg != null) {
            %>
            <div style="color: #dc3545; background-color: rgba(220, 53, 69, 0.1); padding: 10px; border-radius: 5px; margin-bottom: 15px; border-left: 4px solid #dc3545;">
                <%= msg%>
            </div>
            <% }%>

            <br>

            <form action="${pageContext.request.contextPath}/app?task=register" method="POST">
                <div class="input-group">
                    <input 
                        type="text" 
                        id="name" 
                        name="name" 
                        placeholder=" " 
                        required 
                        maxlength="100"
                        autocomplete="off">
                    <label for="name">Nome Completo</label>
                </div>

                <div class="input-group">
                    <input 
                        type="email" 
                        id="email" 
                        name="email" 
                        placeholder=" " 
                        required 
                        maxlength="100"
                        autocomplete="off">
                    <label for="email">E-mail</label>
                </div>

                <div class="input-group">
                    <input 
                        type="text" 
                        id="user" 
                        name="user" 
                        placeholder=" " 
                        required 
                        maxlength="50"
                        autocomplete="off">
                    <label for="user">Usuário</label>
                </div>

                <div class="input-group password-group">
                    <input 
                        type="password" 
                        id="password" 
                        name="password" 
                        placeholder=" " 
                        required
                        autocomplete="off">
                    <label for="password">Senha</label>
                </div>

                <button type="submit" style="width: 100%; margin-top: 10px;">Registrar</button>
            </form>

            <div class="register-link">
                Já tem conta? <a href="${pageContext.request.contextPath}/app/login.jsp">Faça login</a>
            </div>
        </div>
    </body>
</html>
