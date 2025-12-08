<%@page import="model.Category"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    Category c = (Category) request.getAttribute("category");
    boolean editing = (c != null);
    String diff = editing && c.getDifficulty() != null ? c.getDifficulty().toString() : "";
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= editing ? "Editar Categoria" : "Nova Categoria"%> | Task Manager</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
    </head>
    <body>
        <div class="container" style="width:420px; max-width:95vw;">

            <h1><%= editing ? "Editar Categoria" : "Nova Categoria"%></h1>

            <br>

            <form action="${pageContext.request.contextPath}/app" method="post">
                <input type="hidden" name="task" value="category">
                <input type="hidden" name="action" value="<%= editing ? "update" : "create"%>">
                <% if (editing) {%>
                <input type="hidden" name="category_id" value="<%= c.getCategory_id()%>">
                <% }%>

                <div class="input-group">
                    <input type="text" id="name" name="name"
                           value="<%= editing ? c.getName() : ""%>"
                           placeholder=" " required>
                    <label for="name">Nome da categoria</label>
                </div>

                <div class="select-group input-group">
                    <select id="difficulty" name="difficulty" required>
                        <option value="" disabled <%= diff.isEmpty() ? "selected" : ""%>>Selecione</option>
                        <option value="fácil"   <%= "fácil".equalsIgnoreCase(diff) ? "selected" : ""%>>Fácil</option>
                        <option value="médio"   <%= "médio".equalsIgnoreCase(diff) ? "selected" : ""%>>Média</option>
                        <option value="difícil" <%= "difícil".equalsIgnoreCase(diff) ? "selected" : ""%>>Difícil</option>
                    </select>
                    <label for="difficulty">Dificuldade</label>
                </div>

                <button type="submit"><%= editing ? "Salvar alterações" : "Criar categoria"%></button>
            </form>
            <a href="${pageContext.request.contextPath}/app/logged_in/categories.jsp"
               class="back-link">&larr; Voltar para categorias</a>
        </div>
    </body>
</html>
