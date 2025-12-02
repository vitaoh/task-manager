<%@page import="java.util.List"%>
<%@page import="model.Category"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Categorias | Task Manager</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style/style.css">
</head>
<body>
    <div class="container" style="width:420px; max-width:95vw;">
        <div class="categories-header">
            <h1 style="margin:0;">Categorias</h1>
            <!-- chama FrontController para abrir o form -->
            <a href="${pageContext.request.contextPath}/app?task=category&action=new"
               class="new-category-btn">+ Nova</a>
        </div>

        <div class="categories-wrapper">
            <%
                List<Category> categories = (List<Category>) request.getAttribute("categories");
                if (categories == null || categories.isEmpty()) {
            %>
                <p style="color:var(--label-default); font-size:14px;">
                    Nenhuma categoria cadastrada ainda.
                </p>
            <%
                } else {
                    for (Category c : categories) {
            %>
            <div class="category-card">
                <div class="category-info">
                    <span class="category-name"><%= c.getName() %></span>
                    <span class="category-id">#<%= c.getCategory_id() %></span>
                </div>
                <div class="category-actions">
                    <a href="${pageContext.request.contextPath}/app?task=category&action=edit&category_id=<%= c.getCategory_id() %>">
                        Editar
                    </a>
                    <a href="${pageContext.request.contextPath}/app?task=category&action=delete&id=<%= c.getCategory_id() %>"
                       class="delete">
                        Excluir
                    </a>
                </div>
            </div>
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
