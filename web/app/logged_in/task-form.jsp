<%@page import="model.Task"%>
<%@ page import="model.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate, java.time.format.DateTimeFormatter" %>
<%
    LocalDate hoje = LocalDate.now();
    String hojeStr = hoje.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

    Task t = (Task) request.getAttribute("task");
    boolean editing = (t != null);
%>
<%
    List<Category> categorias = (List<Category>) request.getAttribute("categorias");
%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= editing ? "Editar Tarefa" : "Nova Tarefa"%> | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container" style="width:420px; max-width:95vw;">

            <a href="${pageContext.request.contextPath}/app/logged_in/tasks.jsp"
               class="back-link">&larr; Voltar para Tarefas</a>

            <h1><%= editing ? "Editar Tarefa" : "Nova Tarefa"%></h1>

            <form action="${pageContext.request.contextPath}/app" method="post">
                <input type="hidden" name="task" value="task">
                <input type="hidden" name="action" value="<%= editing ? "update" : "create"%>">
                <% if (editing) {%>
                <input type="hidden" name="task_id" value="<%= t.getTask_id()%>">
                <% }%>

                <div class="input-group">
                    <input type="text" id="title" name="title"
                           value="<%= editing ? t.getTitle() : ""%>"
                           placeholder=" " required>
                    <label for="title">Título</label>
                </div>

                <div class="select-group input-group">
                    <textarea id="description" name="description" rows="10" cols="40" placeholder=" "><%= editing && t.getDescription() != null ? t.getDescription() : ""%></textarea>
                    <label for="description">Descrição</label>
                </div>

                <br>

                <div class="row-inline">
                    <div class="select-group input-group">
                        <select id="priority" name="priority" required>
                            <option value="" disabled <%= !editing ? "selected" : ""%>>Selecione</option>
                            <option value="alta"  <%= editing && "alta".equalsIgnoreCase(t.getPriority()) ? "selected" : ""%>>Alta</option>
                            <option value="média" <%= editing && "média".equalsIgnoreCase(t.getPriority()) ? "selected" : ""%>>Média</option>
                            <option value="baixa" <%= editing && "baixa".equalsIgnoreCase(t.getPriority()) ? "selected" : ""%>>Baixa</option>
                        </select>
                        <label for="priority">Prioridade</label>
                    </div>

                    <br>

                    <div class="select-group input-group">
                        <select id="status" name="status" required>
                            <option value="" disabled <%= !editing ? "selected" : ""%>>Selecione</option>
                            <option value="pendente"
                                    <%= editing && "pendente".equalsIgnoreCase(String.valueOf(t.getStatus())) ? "selected" : ""%>>
                                Pendente
                            </option>
                            <option value="em andamento"
                                    <%= editing && "em andamento".equalsIgnoreCase(String.valueOf(t.getStatus())) ? "selected" : ""%>>
                                Em andamento
                            </option>
                            <option value="concluida"
                                    <%= editing && "concluida".equalsIgnoreCase(String.valueOf(t.getStatus())) ? "selected" : ""%>>
                                Concluída
                            </option>
                        </select>
                        <label for="status">Status</label>
                    </div>
                </div>

                <div class="row-inline">
                    <div class="input-group">
                        <input type="date" id="due_date" name="due_date"
                               min="<%= hojeStr%>"
                               value="<%= editing && t.getDue_date() != null ? t.getDue_date().toString() : ""%>"
                               placeholder=" "
                               required>
                        <label for="due_date">Data limite</label>
                    </div>

                    <div class="select-group input-group">
                        <select id="category_id" name="category_id">
                            <option value="0">Sem categoria</option>

                            <% if (categorias != null) {
                                    for (Category c : categorias) {
                                        boolean selected = editing && t.getCategory_id() == c.getCategory_id();
                            %>

                            <option value="<%= c.getCategory_id()%>" <%= selected ? "selected" : ""%>>
                                <%= c.getName()%>
                            </option>

                            <%  }
                                }
                            %>
                        </select>
                        <label for="category_id">Categoria</label>
                    </div>

                </div>

                <button type="submit"><%= editing ? "Salvar alterações" : "Criar tarefa"%></button>
            </form>
        </div>
    </body>
</html>
