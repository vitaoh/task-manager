<%@page import="model.User"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Minha conta | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <style>

        .input-group input[disabled] {
            background: var(--background-secondary);
            color: var(--label-default);
            border-color: var(--input-border);
            opacity: 0.6;
            cursor: not-allowed;
        }

        .input-group input[disabled] + label {
            color: var(--label-default);
            opacity: 0.7;
        }

    </style>
    <body>
        <div class="container" style="width:420px; max-width:95vw;">

            <h1>Minha conta</h1>

            <form action="${pageContext.request.contextPath}/app" method="post">
                <input type="hidden" name="task" value="user">
                <input type="hidden" name="action" value="update">

                <input type="hidden" name="user" value="<%= user.getUser()%>">
                <div class="input-group">
                    <input type="text" id="user_display"
                           value="<%= user.getUser()%>" placeholder=" " disabled>
                    <label for="user_display">Usuário</label>
                </div>

                <div class="input-group">
                    <input type="text" id="name" name="name"
                           value="<%= user.getName()%>" placeholder=" " required>
                    <label for="name">Nome</label>
                </div>

                <div class="input-group">
                    <input type="email" id="email" name="email"
                           value="<%= user.getEmail()%>" placeholder=" " required>
                    <label for="email">E-mail</label>
                </div>

                <input type="hidden" name="password" value="<%= user.getPassword()%>">
                <div class="input-group password-group">
                    <input type="password" id="password_display"
                           value="<%= user.getPassword()%>" placeholder=" " disabled>
                    <label for="password_disply">Senha</label>
                </div>

                <button type="submit">Salvar alterações</button>
            </form>

            <a href="${pageContext.request.contextPath}/app/logged_in/menu.jsp"
               class="back-link">← Voltar para menu</a>

        </div>
    </body>
</html>
