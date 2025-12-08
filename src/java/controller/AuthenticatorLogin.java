package controller;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

public class AuthenticatorLogin implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpServletRequest = (HttpServletRequest) request;
        HttpServletResponse httpServletResponse = (HttpServletResponse) response;

        HttpSession sessao = httpServletRequest.getSession(false);

        if (sessao == null) {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/app?task=login");
            return;
        }

        User user = (User) sessao.getAttribute("user");

        if (user == null) {
            httpServletResponse.sendRedirect(httpServletRequest.getContextPath() + "/app?task=login");
        } else {
            chain.doFilter(request, response);
        }
    }
}
