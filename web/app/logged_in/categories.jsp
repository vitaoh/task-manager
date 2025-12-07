<%@page import="java.util.ArrayList"%>
<%@page import="model.Category"%>
<%@page import="model.User"%>
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
                <a href="${pageContext.request.contextPath}/app?task=category&action=new"
                   class="new-category-btn">+ Nova</a>
            </div>

            <div class="categories-wrapper">
                <%
                    User logged = (User) session.getAttribute("user");
                    String loggedUser = (logged != null) ? logged.getUser() : null;

                    ArrayList<Category> allCategories = new Category().getAllTableEntities();
                    boolean hasAny = false;

                    if (loggedUser == null || allCategories == null || allCategories.isEmpty()) {
                %>
                <p style="color:var(--label-default); font-size:14px;">
                    Nenhuma categoria cadastrada ainda.
                </p>
                <%
                } else {
                    for (Category c : allCategories) {

                        if (!loggedUser.equals(c.getUser())) {
                            continue;
                        }
                        hasAny = true;

                        String diff = c.getDifficulty() != null ? c.getDifficulty().toString() : "";
                        String diffClass
                                = "fácil".equalsIgnoreCase(diff) ? "badge-diff-facil"
                                : "médio".equalsIgnoreCase(diff) ? "badge-diff-media"
                                : "difícil".equalsIgnoreCase(diff) ? "badge-diff-dificil"
                                : "";
                %>
                <div class="category-card">
                    <div class="category-info">
                        <span class="category-name"><%= c.getName()%></span>
                        <span class="category-id">#<%= c.getCategory_id()%></span>
                        <span class="badge-diff <%= diffClass%>">
                            Dificuldade: <%= diff%>
                        </span>
                    </div>
                    <div class="category-actions">
                        <a href="${pageContext.request.contextPath}/app?task=category&action=edit&category_id=<%= c.getCategory_id()%>">
                            Editar
                        </a>
                        <a href="${pageContext.request.contextPath}/app?task=category&action=delete&id=<%= c.getCategory_id()%>"
                           class="delete">
                            Excluir
                        </a>
                    </div>
                </div>
                <%
                    }

                    if (!hasAny) {
                %>
                <p style="color:var(--label-default); font-size:14px;">
                    Nenhuma categoria sua cadastrada ainda.
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
