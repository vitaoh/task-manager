package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import logtrack.ExceptionLogTrack;
import model.Category;
import model.Comment;
import model.Task;
import model.User;

public class FrontController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            switch (task) {
                case "task":
                    doGetTask(request, response);
                    break;
                case "category":
                    doGetCategory(request, response);
                    break;
                case "comment":
                    doGetComment(request, response);
                    break;
                case "user":
                    doGetUser(request, response);
                    break;
                case "logout":
                    doGetLogout(request, response);
                    break;
                default:
                    doDefault(request, response);
            }
        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
            doDefault(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String task = request.getParameter("task");
        if (task == null) {
            task = "";
        }

        try {
            switch (task) {
                case "task":
                    doPostTask(request, response);
                    break;
                case "category":
                    doPostCategory(request, response);
                    break;
                case "comment":
                    doPostComment(request, response);
                    break;
                case "user":
                    doPostUser(request, response);
                    break;
                case "register":
                    doPostRegister(request, response);
                    break;
                case "login":
                    doPostLogin(request, response);
                    break;
                default:
                    doDefault(request, response);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
            ExceptionLogTrack.getInstance().addLog(ex);
            doDefault(request, response);
        }
    }

    private void doGetTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));

            Task task = new Task();
            task.setTask_id(id);
            task.delete();

            response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");

        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("id"));

            Task task = new Task();
            task.setTask_id(id);
            task.load();

            request.setAttribute("task", task);

            java.util.ArrayList<Category> categorias = new Category().getAllTableEntities();
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("/app/logged_in/task-form.jsp")
                    .forward(request, response);

        } else if (action.equals("new")) {

            java.util.ArrayList<Category> categorias = new Category().getAllTableEntities();
            request.setAttribute("categorias", categorias);

            request.getRequestDispatcher("/app/logged_in/task-form.jsp")
                    .forward(request, response);

        } else {
            response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");
        }
    }

    private void doGetCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }

        if (action.equals("delete")) {
            int id = Integer.parseInt(request.getParameter("id"));

            Category category = new Category();
            category.setCategory_id(id);
            category.delete();

            response.sendRedirect(request.getContextPath() + "/app/logged_in/categories.jsp");
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(request.getParameter("category_id"));

            Category category = new Category();
            category.setCategory_id(id);
            category.load();

            request.setAttribute("category", category);
            request.getRequestDispatcher("/app/logged_in/category-form.jsp")
                    .forward(request, response);
        } else if (action.equals("new")) {
            request.getRequestDispatcher("/app/logged_in/category-form.jsp")
                    .forward(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/app/logged_in/categories.jsp");
        }
    }

    private void doGetComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String action = request.getParameter("action");
        String from = request.getParameter("from");

        if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                Comment comment = new Comment();
                comment.setComment_id(id);
                comment.delete();
            } catch (NumberFormatException e) {
                ExceptionLogTrack.getInstance().addLog(e);
            }
        }

        if ("tasks".equals(from)) {
            response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");
        } else {
            response.sendRedirect(request.getContextPath() + "/app/logged_in/comments.jsp");
        }
    }

    private void doGetUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            try {
                String userName = request.getParameter("user");
                if (userName != null && !userName.isEmpty()) {
                    User user = new User();
                    user.setUser(userName);
                    user.delete();
                }
            } catch (Exception e) {
                ExceptionLogTrack.getInstance().addLog(e);
            }
        }

        response.sendRedirect(request.getContextPath() + "/app/logged_in/users.jsp");
    }

    private void doGetLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("user");
            session.invalidate();
        }
        response.sendRedirect(request.getContextPath() + "/app/login.jsp");
    }

    private void doPostTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "create";
            }

            int id = 0;
            if ("update".equals(action)) {
                id = Integer.parseInt(request.getParameter("task_id"));
            }

            String title = request.getParameter("title");
            String description = request.getParameter("description");
            String priority = request.getParameter("priority");
            String status = request.getParameter("status");
            String dueDateStr = request.getParameter("due_date");
            String categoryStr = request.getParameter("category_id");

            HttpSession session = request.getSession(false);
            User userSession = (session != null) ? (User) session.getAttribute("user") : null;
            String userName = (userSession != null) ? userSession.getUser()
                    : request.getParameter("user");

            Task task = new Task();
            task.setTask_id(id);

            if ("update".equals(action)) {
                task.load();
                task.setUpdated_at(new java.sql.Timestamp(System.currentTimeMillis()));
            } else {
                task.setCreated_at(new java.sql.Timestamp(System.currentTimeMillis()));
            }

            task.setTitle(title);
            task.setDescription(description);
            task.setPriority(priority);
            task.setStatus(status);
            task.setUser(userName);

            if (categoryStr != null && !categoryStr.trim().isEmpty()) {
                task.setCategory_id(Integer.parseInt(categoryStr));
            } else {
                task.setCategory_id(0);
            }

            if (dueDateStr == null || dueDateStr.trim().isEmpty()) {
                task.setDue_date(null);
            } else {
                task.setDue_date(java.sql.Date.valueOf(dueDateStr));
            }

            task.save();

            response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");
        } catch (Exception e) {
            ExceptionLogTrack.getInstance().addLog(e);
            response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");
        }
    }

    private void doPostCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {

        String action = request.getParameter("action");

        try {
            if (action == null) {
                action = "create";
            }

            int id = 0;
            if ("update".equals(action)) {
                id = Integer.parseInt(request.getParameter("category_id"));
            }

            String name = request.getParameter("name");
            String difficulty = request.getParameter("difficulty");

            HttpSession session = request.getSession(false);
            User userSession = (session != null) ? (User) session.getAttribute("user") : null;
            String userName = (userSession != null) ? userSession.getUser() : null;

            Category category = new Category();
            category.setCategory_id(id);

            if ("update".equals(action)) {
                category.load();
            }

            category.setName(name);
            category.setDifficulty(difficulty);
            category.setUser(userName);

            category.save();

            response.sendRedirect(request.getContextPath() + "/app/logged_in/categories.jsp");
        } catch (Exception e) {
            ExceptionLogTrack.getInstance().addLog(e);
            response.sendRedirect(request.getContextPath() + "/app/logged_in/categories.jsp");
        }
    }

    private void doPostComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        String action = request.getParameter("action");
        String from = request.getParameter("from");

        try {
            int id = Integer.parseInt(request.getParameter("comment_id"));
            String commentText = request.getParameter("comment");
            int taskId = Integer.parseInt(request.getParameter("task_id"));

            Comment comment = new Comment();
            comment.setComment_id(id);

            if ("update".equals(action)) {
                comment.load();
            }

            comment.setComment(commentText);
            comment.setTask_id(taskId);

            comment.save();

            if ("tasks".equals(from)) {
                response.sendRedirect(request.getContextPath() + "/app/logged_in/tasks.jsp");
            } else {
                response.sendRedirect(request.getContextPath() + "/app/logged_in/comments.jsp");
            }
        } catch (NumberFormatException e) {
            ExceptionLogTrack.getInstance().addLog(e);
            response.sendRedirect(request.getContextPath() + "/app/logged_in/comments.jsp");
        }
    }

    private void doPostUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String action = request.getParameter("action");

        try {
            String userName = request.getParameter("user");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");

            User user = new User();
            user.setUser(userName);

            if ("update".equals(action)) {
                user.load();
            }

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            user.save();

            response.sendRedirect(request.getContextPath() + "/app/logged_in/users.jsp");
        } catch (Exception e) {
            ExceptionLogTrack.getInstance().addLog(e);
            response.sendRedirect(request.getContextPath() + "/app/logged_in/users.jsp");
        }
    }

    private void doPostRegister(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String user = request.getParameter("user");
            String password = request.getParameter("password");

            if (name == null || name.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || user == null || user.trim().isEmpty()
                    || password == null || password.trim().isEmpty()) {

                request.setAttribute("msg", "⚠️ Todos os campos são obrigatórios");
                request.getRequestDispatcher("/app/register.jsp").forward(request, response);
                return;
            }

            if (password.length() < 6) {
                request.setAttribute("msg", "⚠️ A senha deve ter pelo menos 6 caracteres");
                request.getRequestDispatcher("/app/register.jsp").forward(request, response);
                return;
            }

            if (user.length() > 50) {
                request.setAttribute("msg", "⚠️ O usuário não pode ter mais de 50 caracteres");
                request.getRequestDispatcher("/app/register.jsp").forward(request, response);
                return;
            }

            if (!email.contains("@") || !email.contains(".")) {
                request.setAttribute("msg", "⚠️ E-mail inválido");
                request.getRequestDispatcher("/app/register.jsp").forward(request, response);
                return;
            }

            User userCheck = new User();
            userCheck.setUser(user);

            try {
                if (userCheck.load()) {
                    request.setAttribute("msg", "⚠️ Este usuário já existe. Escolha outro!");
                    request.getRequestDispatcher("/app/register.jsp").forward(request, response);
                    return;
                }
            } catch (Exception e) {
                ExceptionLogTrack.getInstance().addLog(e);
            }

            User newUser = new User();
            newUser.setName(name);
            newUser.setEmail(email);
            newUser.setUser(user);
            newUser.setPassword(password);

            newUser.save();

            request.setAttribute("msg", "✅ Registro realizado com sucesso! Faça login agora.");
            request.getRequestDispatcher("/app/login.jsp").forward(request, response);

        } catch (Exception e) {
            ExceptionLogTrack.getInstance().addLog(e);
            request.setAttribute("msg", "❌ Erro ao registrar: " + e.getMessage());
            request.getRequestDispatcher("/app/register.jsp").forward(request, response);
        }
    }

    private void doPostLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {

        try {
            String userName = request.getParameter("user");
            String passwordRaw = request.getParameter("password");

            if (userName == null || userName.trim().isEmpty() || passwordRaw == null || passwordRaw.trim().isEmpty()) {
                request.setAttribute("msg", "⚠️ Usuário e senha são obrigatórios");
                request.getRequestDispatcher("/app/login.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setUser(userName);
            boolean loaded = user.load();

            if (!loaded) {
                request.setAttribute("msg", "❌ Usuário ou senha incorreta");
                request.getRequestDispatcher("/app/login.jsp").forward(request, response);
                return;
            }

            User userTemp = new User();
            userTemp.setUser(userName);
            userTemp.setPassword(passwordRaw);

            if (user.getPassword().equals(userTemp.getPassword())) {

                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }

                session = request.getSession(true);
                session.setAttribute("user", user);
                session.setMaxInactiveInterval(60 * 60);

                Cookie cookie = new Cookie("user", userName);
                cookie.setMaxAge(60 * 10);
                cookie.setPath(request.getContextPath());
                response.addCookie(cookie);

                response.sendRedirect(request.getContextPath() + "/app/logged_in/menu.jsp");
            } else {
                request.setAttribute("msg", "❌ Usuário ou senha incorreta");
                request.getRequestDispatcher("/app/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("msg", "❌ Erro ao processar login");
            request.getRequestDispatcher("/app/login.jsp").forward(request, response);
            ExceptionLogTrack.getInstance().addLog(e);
        }
    }

    private void doDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/app/login.jsp");
    }
}
