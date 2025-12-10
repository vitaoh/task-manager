<%@page import="model.User" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Menu | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container">
            <h1>Menu</h1>
            <h2>Bem-vindo, <%= user.getName()%>!</h2>
            <nav>
                <ul style="list-style:none; padding:0;">
                    <li><a href="${pageContext.request.contextPath}/app/logged_in/tasks.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none; margin-bottom:5px;">📋 Tarefas</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/logged_in/categories.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none; margin-bottom:5px;">📁 Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/logged_in/comments.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none; margin-bottom:5px;">💬 Comentários</a></li>
                    <li><a href="${pageContext.request.contextPath}/app/logged_in/account.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none; margin-bottom:5px;">👤 Editar conta</a></li>
                    <li><a href="${pageContext.request.contextPath}/app?task=logout" style="display:block; padding:10px; border-radius:5px; color:#dc3545; text-decoration:none;">🚪 Logout, (<%= user.getUser()%>)</a></li>
                </ul>
            </nav>
        </div>
    </body>
</html>
