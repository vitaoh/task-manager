<%@page import="model.User" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/app/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Categorias | Task Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
</head>
<body>
    <div class="container">
        <h1>Categorias</h1>
        <a href="category-form.jsp" style="display:inline-block; margin-bottom:20px; background:#007bff; color:#fff; padding:10px 15px; border-radius:5px; text-decoration:none;">+ Nova Categoria</a>
        
        <table style="width:100%; border-collapse: collapse;">
            <thead>
                <tr style="background:#f0f0f0;">
                    <th style="padding:10px; border:1px solid #ddd;">ID</th>
                    <th style="padding:10px; border:1px solid #ddd;">Nome</th>
                    <th style="padding:10px; border:1px solid #ddd;">Ações</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="padding:10px; border:1px solid #ddd;">1</td>
                    <td style="padding:10px; border:1px solid #ddd;">Trabalho</td>
                    <td style="padding:10px; border:1px solid #ddd;">
                        <a href="category-edit.jsp?id=1" style="color:#007bff; margin-right:10px;">Editar</a>
                        <a href="${pageContext.request.contextPath}/app?task=category&action=delete&id=1" style="color:#dc3545;">Excluir</a>
                    </td>
                </tr>
            </tbody>
        </table>
        <br>
        <a href="menu.jsp" style="color:#007bff;">← Voltar ao menu</a>
    </div>
</body>
</html>
