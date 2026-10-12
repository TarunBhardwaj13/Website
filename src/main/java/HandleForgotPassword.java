import DB.HandleDatabase;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgotPassword")
public class HandleForgotPassword extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String newPassword = req.getParameter("newPassword");
        String confirmPassword = req.getParameter("confirmPassword");

        // Check if passwords match
        if (!newPassword.equals(confirmPassword)) {
            req.setAttribute("Error", "Passwords do not match!");
            req.getRequestDispatcher("forgot.jsp").forward(req, resp);
            return;
        }

        HandleDatabase db = new HandleDatabase();

        boolean status = db.updatePassword(username, newPassword);

        System.out.println("Username = " + username);
        System.out.println("Status = " + status);

        db.close();

        if (status) {
            req.setAttribute("Success", "Password reset successfully.");
            req.getRequestDispatcher("forgot.jsp").forward(req, resp);
        } else {
            req.setAttribute("Error", "Username/Email not found");
            req.getRequestDispatcher("forgot.jsp").forward(req, resp);
        }
    }
}