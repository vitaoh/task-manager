<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <nav>
                <ul style="list-style:none; padding:0;">
                    <li><a href="${pageContext.request.contextPath}/logged_in/tasks.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none;">Tarefas</a></li>
                    <li><a href="${pageContext.request.contextPath}/logged_in/categories.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none;">Categorias</a></li>
                    <li><a href="${pageContext.request.contextPath}/logged_in/comments.jsp" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none;">Comentários</a></li>
                    <li><a href="${pageContext.request.contextPath}/app?task=logout" style="display:block; padding:10px; border-radius:5px; color:#007bff; text-decoration:none;">Logout <%= usuarioLogado%></a></li>
                </ul>
            </nav>
        </div>
    </body>
</html>
