import DB.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;



@WebServlet("/login")

public class HandleLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        HandleDatabase db = new HandleDatabase();

        String username = req.getParameter("user_email");
        String password = req.getParameter("password");

        String name = db.validateUser(username, password);

        if (name.equals("none")){
            req.setAttribute("Error", "Invalid username or password");
            resp.sendRedirect("index.jsp");
        } else {

            req.setAttribute("Success", "Successfully login");

            session.setAttribute("username", name);

            int userId = db.getUserId(username);

            session.setAttribute("isAdmin", db.isAdmin(userId));

            session.setAttribute("user", username);
            session.setAttribute("userId", userId);

            resp.sendRedirect("homePage.jsp");
        }
    }

}
