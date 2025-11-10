<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="pt-BR">
    <head>
        <meta charset="UTF-8">
        <title>Registrar | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">    
    </head>
    <body>
        <div class="container">
            <h1>Registrar</h1>
            <br>
            <br>

            <form action="register" method="post">
                <label for="name">Nome completo</label>
                <input type="text" id="name" name="name" required>
                <br>

                <label for="email">E-mail</label>
                <input type="email" id="email" name="email" required>
                <br>

                <label for="user">Usuário</label>
                <input type="text" id="user" name="user" required>
                <br>

                <label for="password">Senha</label>
                <input type="password" id="password" name="password" required>
                <br>

                <button type="submit">Registrar</button>
            </form>

            <div class="register-link">
                Já tem conta? <a href="${pageContext.request.contextPath}/app/login.jsp">Faça login</a>
            </div>
        </div>
    </body>
</html>
