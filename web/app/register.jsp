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

                <div class="input-group">
                    <input type="text" id="name" name="name" placeholder=" " required maxlength="50">
                    <label for="name">Nome</label>
                </div>

                <div class="input-group">
                    <input type="email" id="email" name="email" placeholder=" " required maxlength="50">
                    <label for="email">E-mail</label>
                </div>

                <div class="input-group">
                    <input type="text" id="user" name="user" placeholder=" " required maxlength="50">
                    <label for="user">Usuário</label>
                </div>

                <div class="input-group">
                    <input type="password" id="password" name="password" placeholder=" " required>
                    <label for="password">Senha</label>
                </div>

                <button type="submit">Registrar</button>
            </form>

            <div class="register-link">
                Já tem conta? <a href="${pageContext.request.contextPath}/app/login.jsp">Faça login</a>
            </div>
        </div>
    </body>
</html>
