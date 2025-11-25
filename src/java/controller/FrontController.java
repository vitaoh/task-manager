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
                case "usuario":
                    doGetUsuario(request, response);
                    break;
                case "logout":
                    doGetLogout(request, response);
                    break;
                default:
                    doDefault(request, response);
            }
        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
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
                case "usuario":
                    doPostUsuario(request, response);
                    break;
                case "login":
                    doPostLogin(request, response);
                    break;
                default:
                    doDefault(request, response);
            }
        } catch (Exception ex) {
            ExceptionLogTrack.getInstance().addLog(ex);
        }
    }

    private void doGetTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // implementar listagem, detalhes, exclusão, etc.
        String action = request.getParameter("action");
        if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            Task task = new Task();
            task.setTask_id(id);
            task.delete();
        }
        response.sendRedirect(request.getContextPath() + "/app/loge/tasks.jsp");
    }

    private void doPostTask(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        // implementar criação e atualização de tarefas
        String action = request.getParameter("action");
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String priority = request.getParameter("priority");
        // demais campos...

        Task task = new Task();
        task.setTask_id(id);

        if ("update".equals(action)) {
            task.load();
        }

        task.setTitle(title);
        task.setDescription(description);
        task.setPriority(priority);
        // setar demais campos...

        task.save();

        response.sendRedirect(request.getContextPath() + "/home/app/task/tasks.jsp");
    }

    private void doGetCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Similar ao doGetTask para categories
        response.sendRedirect(request.getContextPath() + "/home/app/category/categories.jsp");
    }

    private void doPostCategory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Similar ao doPostTask para categories
        response.sendRedirect(request.getContextPath() + "/home/app/category/categories.jsp");
    }

    private void doGetComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Similar para comentários
        response.sendRedirect(request.getContextPath() + "/home/app/comment/comments.jsp");
    }

    private void doPostComment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Similar para comentários
        response.sendRedirect(request.getContextPath() + "/home/app/comment/comments.jsp");
    }

    private void doGetUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Seu código atual para usuário GET
    }

    private void doPostUsuario(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Seu código atual para usuário POST
    }

    private void doPostLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Seu código atual para login
    }

    private void doGetLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Seu código atual para logout
    }

    private void doDefault(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/home/login.jsp");
    }
}
