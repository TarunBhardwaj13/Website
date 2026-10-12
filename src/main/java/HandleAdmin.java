import DB.HandleDatabase;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/handleAdmin")
public class HandleAdmin extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HandleDatabase db = new HandleDatabase();
        int userId = Integer.parseInt(req.getParameter("userId"));
        String action = req.getParameter("action");

        if("make".equals(action)){

            db.updateAdmin(userId, true);

        }else if(action.equals("remove")){

            db.updateAdmin(userId, false);
        }

        resp.sendRedirect("manageAdmin.jsp");
    }
}
