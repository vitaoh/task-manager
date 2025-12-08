<%@page import="java.util.ArrayList"%>
<%@page import="model.Task"%>
<%@page import="model.Comment"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String from = request.getParameter("from");
    if (from == null) {
        from = "comments";
    }

    String idStr = request.getParameter("comment_id");
    Comment c = null;
    boolean editing = false;

    if (idStr != null && !idStr.trim().isEmpty()) {
        try {
            int id = Integer.parseInt(idStr);
            c = new Comment();
            c.setComment_id(id);
            c.load();
            editing = true;
        } catch (Exception e) {
        }
    }
    if (!editing) {
        c = new Comment();
    }

    String taskIdParam = request.getParameter("task_id");
    int defaultTaskId = 0;
    try {
        if (taskIdParam != null && !taskIdParam.trim().isEmpty()) {
            defaultTaskId = Integer.parseInt(taskIdParam);
        }
    } catch (Exception e) {
    }

    ArrayList<Task> tasks = new Task().getAllTableEntities();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= editing ? "Editar Comentário" : "Novo Comentário"%> | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container" style="width:420px; max-width:95vw;">

            <h1><%= editing ? "Editar Comentário" : "Novo Comentário"%></h1>

            <form action="${pageContext.request.contextPath}/app" method="post">
                <input type="hidden" name="task" value="comment">
                <input type="hidden" name="action" value="<%= editing ? "update" : "create"%>">
                <input type="hidden" name="comment_id" value="<%= editing ? c.getComment_id() : 0%>">
                <input type="hidden" name="from" value="<%= from%>">

                <div class="select-group input-group">
                    <textarea id="comment" name="comment" rows="5" cols="40" placeholder=" " required><%= editing ? c.getComment() : ""%></textarea>
                    <label for="comment">Comentário</label>
                </div>

                <div class="select-group input-group">
                    <select id="task_id" name="task_id" required>
                        <option value="" disabled <%= (!editing && defaultTaskId == 0) ? "selected" : ""%>>
                            Selecione a tarefa
                        </option>

                        <% if (tasks != null) {
                                for (Task t : tasks) {
                                    boolean selected;
                                    if (editing) {
                                        selected = (c.getTask_id() == t.getTask_id());
                                    } else {
                                        selected = (defaultTaskId == t.getTask_id());
                                    }
                        %>
                        <option value="<%= t.getTask_id()%>" <%= selected ? "selected" : ""%>>
                            #<%= t.getTask_id()%> - <%= t.getTitle()%>
                        </option>
                        <%     }
                            }
                        %>
                    </select>
                    <label for="task_id">Tarefa</label>
                </div>

                <button type="submit"><%= editing ? "Salvar alterações" : "Criar comentário"%></button>
            </form>

            <a href="<%= "tasks".equals(from)
                    ? (request.getContextPath() + "/app/logged_in/tasks.jsp")
                    : (request.getContextPath() + "/app/logged_in/comments.jsp")%>"
               class="back-link">← Voltar</a>

        </div>
    </body>
</html>