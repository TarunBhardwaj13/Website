package controller; // Apna actual package name check kar lena (e.g. package controller;)

import DB.HandleDatabase;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.ResultSet;
import java.util.*;

@WebServlet("/HandleOrderHistory")
public class HandleOrderHistory extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // 1. Session Check (Agar login nahi hai toh login page par bhejein)
        if (session == null || (session.getAttribute("userId") == null && session.getAttribute("user") == null)) {
            response.sendRedirect("login.jsp");
            return;
        }

        HandleDatabase db = new HandleDatabase();
        int userId = -1;

        // 2. Direct Session se Valid User ID Fetch Karein (Fix for -1 issue)
        if (session.getAttribute("userId") != null) {
            userId = (Integer) session.getAttribute("userId");
        } else if (session.getAttribute("user") != null) {
            String usernameOrEmail = (String) session.getAttribute("user");
            userId = db.getUserId(usernameOrEmail);
        }

        System.out.println("LOG -> Fetching Order History for User ID: " + userId);

        List<Map<String, Object>> orderList = new ArrayList<>();

        if (userId != -1) {
            // Customer table se logged-in user ke saare orders fetch karein
            ResultSet rs = db.getUserOrdersFromCustomerTable(userId);
            try {
                if (rs != null) {
                    while (rs.next()) {
                        Map<String, Object> order = new HashMap<>();
                        order.put("orderId", rs.getInt("id"));
                        order.put("totalAmount", rs.getString("payment_amount"));
                        order.put("paymentStatus", rs.getString("payment_status"));
                        order.put("productsDetail", rs.getString("products_detail"));
                        order.put("orderDate", rs.getTimestamp("order_date"));
                        order.put("address", rs.getString("address") + ", " + rs.getString("city"));

                        orderList.add(order);
                    }
                }
            } catch (Exception e) {
                System.out.println("Error parsing ResultSet in HandleOrderHistory: " + e.getMessage());
                e.printStackTrace();
            } finally {
                db.close(); // Connection Band karna zaroori hai
            }
        }

        // JSP page ko orderList bhej rahe hain
        request.setAttribute("ordersList", orderList);
        request.getRequestDispatcher("orderHistory.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}