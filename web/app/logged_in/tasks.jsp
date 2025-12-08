<%@page import="model.Category"%>
<%@page import="java.util.List"%>
<%@page import="model.User, model.Task, model.Comment, java.util.ArrayList" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Tarefas | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container" style="width:800px; max-width:95vw;">
            <div class="tasks-header">
                <h1 style="margin:0;">Tarefas</h1>
                <a href="${pageContext.request.contextPath}/app?task=task&action=new" class="new-task-btn">+ Nova</a>
            </div>

            <div class="tasks-wrapper">
                <%
                    User logged = (User) session.getAttribute("user");
                    String loggedUser = (logged != null) ? logged.getUser() : null;

                    ArrayList<Task> allTasks = new Task().getAllTableEntities();
                    ArrayList<Comment> allComments = new Comment().getAllTableEntities();
                    boolean hasAny = false;

                    if (loggedUser == null || allTasks == null || allTasks.isEmpty()) {
                %>
                <p style="color:var(--label-default); font-size:14px;">Nenhuma tarefa cadastrada ainda.</p>
                <%
                } else {
                    for (Task t : allTasks) {
                        if (!loggedUser.equals(t.getUser())) {
                            continue;
                        }
                        hasAny = true;

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
                            String dueDate = (t.getDue_date() != null) ? t.getDue_date().toString() : null;
                        %>
                        <% if (dueDate != null) {%>
                        <span class="badge badge-due">
                            Vence em: <%= dueDate%>
                        </span>
                        <% } %>

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
                        <span class="badge">Categoria ID: <%= t.getCategory_id()%></span>
                        <span class="badge">Nome Categoria: <%= c.getName()%></span>
                        <% }%>
                    </div>

                    <div class="task-description">
                        <strong>Descrição:</strong><br>
                        <%= (t.getDescription() != null && !t.getDescription().isBlank())
                                ? t.getDescription()
                                : "Nenhuma descrição informada."%>
                    </div>

                    <div class="task-dates" style="margin-bottom: 12px">
                        Criada em: <%= createdAt%><br>
                        <% if (updatedAt != null) {%>
                        Atualizada em: <%= updatedAt%>
                        <% } else { %>
                        Nunca atualizada
                        <% }%>
                    </div>


                    <div class="task-comments" style="margin-top:8px; font-size:13px;">
                        <span style="font-weight:600; color:var(--label-float);">
                            Comentários:
                        </span>
                        <a href="${pageContext.request.contextPath}/app/logged_in/comment-form.jsp?task_id=<%= t.getTask_id()%>&from=tasks"
                           style="font-size:12px; margin-left:8px; text-decoration:none; color:#007bff;">
                            + Adicionar
                        </a>

                        <br>
                        <%
                            boolean hasComments = false;
                            if (allComments != null) {
                                for (Comment cmt : allComments) {
                                    if (cmt.getTask_id() == t.getTask_id()) {
                                        hasComments = true;
                        %>
                        <div style="margin-top:4px; padding:4px 8px;
                             border-left:2px solid var(--input-border);
                             display:flex; justify-content:space-between; align-items:center;">
                            <span style="color:var(--description-text);">
                                #<%= cmt.getComment_id()%>: <%= cmt.getComment()%>
                            </span>
                            <span>
                                <a href="${pageContext.request.contextPath}/app/logged_in/comment-form.jsp?comment_id=<%= cmt.getComment_id()%>&from=tasks"
                                   style="font-size:12px; color:#007bff; margin-right:8px; text-decoration:none;">
                                    Editar
                                </a>
                                <a href="${pageContext.request.contextPath}/app?task=comment&action=delete&id=<%= cmt.getComment_id()%>&from=tasks"
                                   style="font-size:12px; color:#dc3545; text-decoration:none;">
                                    Excluir
                                </a>
                            </span>
                        </div>
                        <%
                                    }
                                }
                            }
                            if (!hasComments) {
                        %>
                        <span style="color:var(--label-default);">Nenhum comentário ainda.</span>
                        <%
                            }
                        %>
                    </div>

                    <br>

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

                    if (!hasAny) {
                %>
                <p style="color:var(--label-default); font-size:14px;">Nenhuma tarefa sua cadastrada ainda.</p>
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
