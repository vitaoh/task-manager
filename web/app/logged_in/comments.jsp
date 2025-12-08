<%@page import="java.util.ArrayList"%>
<%@page import="model.Comment"%>
<%@page import="model.Task"%>
<%@page import="model.User"%>
<%@page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Comentários | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container" style="width:640px; max-width:95vw;">

            <div class="tasks-header">
                <h1 style="margin:0;">Comentários</h1>
                <a href="${pageContext.request.contextPath}/app/logged_in/comment-form.jsp?from=comments"
                   class="new-task-btn">+ Novo</a>
            </div>

            <div class="tasks-wrapper">
                <%
                    User logged = (User) session.getAttribute("user");
                    String loggedUser = (logged != null) ? logged.getUser() : null;

                    ArrayList<Comment> allComments = new Comment().getAllTableEntities();
                    boolean hasAny = false;

                    if (loggedUser == null || allComments == null || allComments.isEmpty()) {
                %>
                <p style="color:var(--label-default); font-size:14px;">
                    Nenhum comentário cadastrado ainda.
                </p>
                <%
                } else {
                    for (Comment c : allComments) {
                        Task t = new Task();
                        t.setTask_id(c.getTask_id());
                        boolean show = false;
                        String taskTitle = "";
                        try {
                            if (t.load() && loggedUser.equals(t.getUser())) {
                                show = true;
                                taskTitle = t.getTitle();
                            }
                        } catch (Exception e) {
                        }

                        if (!show) {
                            continue;
                        }
                        hasAny = true;
                %>

                <div class="task-card">
                    <div class="task-card-header">
                        <div>
                            <div class="task-title">Comentário #<%= c.getComment_id()%></div>
                            <div class="task-id">
                                Tarefa: #<%= c.getTask_id()%> - <%= taskTitle%>
                            </div>
                        </div>
                    </div>

                    <div class="task-description">
                        <strong>Texto:</strong><br>
                        <%= c.getComment()%>
                    </div>

                    <div class="task-actions">
                        <a href="${pageContext.request.contextPath}/app/logged_in/comment-form.jsp?comment_id=<%= c.getComment_id()%>">
                            Editar
                        </a>
                        <a href="${pageContext.request.contextPath}/app?task=comment&action=delete&id=<%= c.getComment_id()%>"
                           class="delete">
                            Excluir
                        </a>
                    </div>
                </div>

                <%
                    } // fim for

                    if (!hasAny) {
                %>
                <p style="color:var(--label-default); font-size:14px;">
                    Nenhum comentário das suas tarefas ainda.
                </p>
                <%
                        }
                    }
                %>
            </div>

            <a href="${pageContext.request.contextPath}/app/logged_in/menu.jsp"
               class="back-link">← Voltar ao menu</a>
        </div>
    </body>
</html>
