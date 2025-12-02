<%@page import="java.util.List"%>
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
        <div class="container" style="width:420px; max-width:95vw;">
            <div class="tasks-header">
                <h1 style="margin:0;">Tarefas</h1>
                <a href="task-form.jsp" class="new-task-btn">+ Nova</a>
            </div>

            <div class="tasks-wrapper">
                <%
                    List<Task> tasks = (List<Task>) request.getAttribute("tasks");
                    if (tasks == null || tasks.isEmpty()) {
                %>
                <p style="color:var(--label-default); font-size:14px;">Nenhuma tarefa cadastrada ainda.</p>
                <%
                    } else {
                        for (Task t : tasks) {
                            String prioridade = t.getPriority();   // ex: ALTA, MEDIA, BAIXA
                            String status = t.getStatus();     // ex: PENDENTE, CONCLUIDA
                            String createdAt = t.getCreated_at().toString();   // DATETIME
                            java.util.Date upd = t.getUpdated_at();
                            String updatedAt = (upd != null ? upd.toString() : null);
                %>
                <div class="task-card">
                    <div class="task-card-header">
                        <div>
                            <div class="task-title"><%= t.getTitle()%></div>
                            <div class="task-id">#<%= t.getTask_id()%></div>
                        </div>
                    </div>

                    <div class="task-badges">
                        <span class="badge 
                              <%= "ALTA".equalsIgnoreCase(prioridade) ? "prio-alta"
                                      : "MEDIA".equalsIgnoreCase(prioridade) ? "prio-media"
                                      : "prio-baixa"%>">
                            Prioridade: <%= prioridade%>
                        </span>
                        <span class="badge badge-status">
                            Status: <%= status%>
                        </span>
                        <% if (t.getCategory_id() != 0) {%>
                        <span class="badge">Categoria ID: <%= t.getCategory_id()%></span>
                        <% }%>
                    </div>

                    <div class="task-dates">
                        Criada em: <%= createdAt%><br>
                        <% if (updatedAt != null) {%>
                        Atualizada em: <%= updatedAt%>
                        <% } else { %>
                        Nunca atualizada
                        <% }%>
                    </div>

                    <div class="task-actions">
                        <a href="task-edit.jsp?id=<%= t.getTask_id()%>">Editar</a>
                        <a href="${pageContext.request.contextPath}/app?task=task&amp;action=delete&amp;id=<%= t.getTask_id()%>" 
                           class="delete">Excluir</a>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </body>
</html>
