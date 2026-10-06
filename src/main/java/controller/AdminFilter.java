package controller;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import util.WebUtil;

import java.io.IOException;

@WebFilter(urlPatterns = {"/dashboard", "/dashboard.jsp"})
public class AdminFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        if (!WebUtil.esAdmin(req)) {
            resp.sendRedirect(req.getContextPath() + "/login?admin=1");
            return;
        }
        chain.doFilter(request, response);
    }
}
