<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

            <form action="login" method="post">
                <label for="user">Usuário</label>
                <input type="text" id="user" name="user" required>
                <br>

                <label for="password">Senha</label>
                <input type="password" id="password" name="password" required>
                <br>
                
                <button type="submit">Entrar</button>
            </form>

            <div class="register-link">
                Ainda não tem conta? 
                <a href="${pageContext.request.contextPath}/app/register.jsp">Cadastre-se</a>
            </div>
        </div>
    </body>
</html>
