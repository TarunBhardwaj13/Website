import DB.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;


@WebServlet("/signup")

public class HandleSignup extends HttpServlet{


    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // HttpSession session = req.getSession();
        HandleDatabase db = new HandleDatabase();
        // resp.setContentType("text/html");
        // PrintWriter out = resp.getWriter();
        // out.println("Hello");
        String name = req.getParameter("name");
        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");

        boolean status = db.insertData(name, username, password, email);
        // System.out.println(status);
        // out.close();
        if (status) {
            req.setAttribute("Success","Successfully Login");
            resp.sendRedirect("index.jsp");
        } else {
            req.setAttribute("Error", "Failed to login...");
        }
    }
}