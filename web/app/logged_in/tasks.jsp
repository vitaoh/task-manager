<%@page import="model.User, model.Task, java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tarefas | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container">
            <h1>Tarefas</h1>
            <a href="task-form.jsp" style="display:inline-block; margin-bottom:20px; background:#007bff; color:#fff; padding:10px 15px; border-radius:5px; text-decoration:none;">+ Nova Tarefa</a>

            <table style="width:100%; border-collapse: collapse;">
                <thead>
                    <tr style="background:#f0f0f0;">
                        <th style="padding:10px; border:1px solid #ddd;">ID</th>
                        <th style="padding:10px; border:1px solid #ddd;">Título</th>
                        <th style="padding:10px; border:1px solid #ddd;">Prioridade</th>
                        <th style="padding:10px; border:1px solid #ddd;">Status</th>
                        <th style="padding:10px; border:1px solid #ddd;">Ações</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td style="padding:10px; border:1px solid #ddd;">1</td>
                        <td style="padding:10px; border:1px solid #ddd;">Exemplo</td>
                        <td style="padding:10px; border:1px solid #ddd;">Alta</td>
                        <td style="padding:10px; border:1px solid #ddd;">Pendente</td>
                        <td style="padding:10px; border:1px solid #ddd;">
                            <a href="task-edit.jsp?id=1" style="color:#007bff; margin-right:10px;">Editar</a>
                            <a href="${pageContext.request.contextPath}/app?task=task&action=delete&id=1" style="color:#dc3545;">Excluir</a>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
    </body>
</html>
