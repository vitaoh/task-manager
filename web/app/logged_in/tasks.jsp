<%@page import="model.Category"%>
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
        <div class="container" style="width:640px; max-width:95vw;">
            <div class="tasks-header">
                <h1 style="margin:0;">Tarefas</h1>
                <a href="${pageContext.request.contextPath}/app?task=task&action=new" class="new-task-btn">+ Nova</a>
            </div>

            <div class="tasks-wrapper">
                <%
                    ArrayList<Task> tasks = new Task().getAllTableEntities();
                    if (tasks == null || tasks.isEmpty()) {
                %>
                <p style="color:var(--label-default); font-size:14px;">Nenhuma tarefa cadastrada ainda.</p>
                <%
                } else {
                    for (Task t : tasks) {
                        String prioridade = t.getPriority();
                        String status = t.getStatus();

                        String createdAt = "";
                        if (t.getCreated_at() != null) {
                            createdAt = t.getCreated_at().toString();
                            int dot = createdAt.indexOf('.');
                            if (dot > 0) {
                                createdAt = createdAt.substring(0, dot);
                            }
                        }

                        String updatedAt = null;
                        if (t.getUpdated_at() != null) {
                            updatedAt = t.getUpdated_at().toString();
                            int dot2 = updatedAt.indexOf('.');
                            if (dot2 > 0) {
                                updatedAt = updatedAt.substring(0, dot2);
                            }
                        }
                %>
                <div class="task-card">
                    <div class="task-card-header">
                        <div>
                            <div class="task-title"><%= t.getTitle()%></div>
                            <div class="task-id">#<%= t.getTask_id()%></div>
                        </div>
                    </div>

                    <div class="task-badges">
                        <span class="badge badge-status
                              <%= "ALTA".equalsIgnoreCase(prioridade) ? "prio-alta"
                                      : "MÉDIA".equalsIgnoreCase(prioridade) ? "prio-media"
                                      : "prio-baixa"%>">
                            Prioridade: <%= prioridade%>
                        </span>

                        <span class="badge badge-status 
                              <%= "PENDENTE".equalsIgnoreCase(status) ? "status-pendente"
                                      : "EM ANDAMENTO".equalsIgnoreCase(status) ? "status-em-andamento"
                                      : "status-concluida"%>">
                            Status: <%= status%>
                        </span>

                        <%
                            Category c = null;

                            if (t.getCategory_id() != 0) {
                                c = new Category();
                                c.setCategory_id(t.getCategory_id());
                                c.load();
                            }

                            String diff = (c != null && c.getDifficulty() != null) ? c.getDifficulty().toString() : "";
                            String diffClass
                                    = "fácil".equalsIgnoreCase(diff) ? "badge-diff-facil"
                                    : "médio".equalsIgnoreCase(diff) ? "badge-diff-media"
                                    : "difícil".equalsIgnoreCase(diff) ? "badge-diff-dificil"
                                    : "";
                        %>

                        <% if (c != null) {%>
                        <span class="badge-diff <%= diffClass%>">
                            Dificuldade: <%= diff%>
                        </span>
                        <% }%>

                        <% if (t.getCategory_id() != 0) {%>
                        <span class="badge">Categoria ID: <%= t.getCategory_id()%></span>
                        <% }%>


                        <% if (c != null) {%>
                        <span class="badge">Nome Categoria: <%= c.getName()%></span>
                        <% }%>

                    </div>

                    <div class="task-description">
                        <strong>Descrição:</strong><br>
                        <%= (t.getDescription() != null && !t.getDescription().isBlank())
                                ? t.getDescription()
                                : "Nenhuma descrição informada."%>
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
                        <a href="${pageContext.request.contextPath}/app?task=task&action=edit&id=<%= t.getTask_id()%>">
                            Editar
                        </a>
                        <a href="${pageContext.request.contextPath}/app?task=task&amp;action=delete&amp;id=<%= t.getTask_id()%>" 
                           class="delete">Excluir</a>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>
            <a href="${pageContext.request.contextPath}/app/logged_in/menu.jsp"
               class="back-link">&larr; Voltar para Menu</a>
        </div>
    </body>
</html>
