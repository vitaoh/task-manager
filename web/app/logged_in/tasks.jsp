<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <a href="${pageContext.request.contextPath}/task-form.jsp" style="display:inline-block; margin-bottom:20px; background:#007bff; color:#fff; padding:10px 15px; border-radius:5px; text-decoration:none;">Nova Tarefa</a>
        
        <table style="width:100%; border-collapse: collapse;">
            <thead>
                <tr style="background:#f0f0f0;">
                    <th style="padding:8px; border-bottom:1px solid #ccc;">ID</th>
                    <th style="padding:8px; border-bottom:1px solid #ccc;">Título</th>
                    <th style="padding:8px; border-bottom:1px solid #ccc;">Prioridade</th>
                    <th style="padding:8px; border-bottom:1px solid #ccc;">Data de Vencimento</th>
                    <th style="padding:8px; border-bottom:1px solid #ccc;">Ações</th>
                </tr>
            </thead>
            <tbody>
                <%-- Exemplo estático, substitua por iteração dinâmica no backend --%>
                <tr>
                    <td style="padding:8px; border-bottom:1px solid #ccc;">1</td>
                    <td style="padding:8px; border-bottom:1px solid #ccc;">Exemplo de Tarefa</td>
                    <td style="padding:8px; border-bottom:1px solid #ccc;">Alta</td>
                    <td style="padding:8px; border-bottom:1px solid #ccc;">25/11/2025</td>
                    <td style="padding:8px; border-bottom:1px solid #ccc;">
                        <a href="${pageContext.request.contextPath}/task-details.jsp?id=1" style="margin-right:10px; color:#007bff;">Ver</a>
                        <a href="${pageContext.request.contextPath}/task-edit.jsp?id=1" style="color:#007bff;">Editar</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
</html>
