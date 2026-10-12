package controller; // Apna actual package name yahan likhein (e.g., package controller;)

import DB.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/order")
public class HandleOrder extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        HandleDatabase db = new HandleDatabase();

        try {
            // 1. Fetch Form Parameters
            String fullName = req.getParameter("fullName");
            String mobileNumber = req.getParameter("mobileNumber");
            String pincode = req.getParameter("pincode");
            String locality = req.getParameter("locality");
            String address = req.getParameter("address");
            String landmark = req.getParameter("landmark");
            String city = req.getParameter("city");
            String state = req.getParameter("state");
            String addressType = req.getParameter("addressType");

            String paymentAmount = req.getParameter("payment_amount");
            String paymentStatus = req.getParameter("payment_status");
            String transactionId = req.getParameter("transactionId");

            if (paymentAmount == null || paymentAmount.trim().isEmpty()) paymentAmount = "0.00";
            if (paymentStatus == null || paymentStatus.trim().isEmpty()) paymentStatus = "Cash On Delivery";
            if (transactionId == null || transactionId.trim().isEmpty()) transactionId = "-";

            // 2. Direct Session se Valid User ID Fetch Karein (Fix for -1 issue)
            int userId = -1;
            if (session != null && session.getAttribute("userId") != null) {
                userId = (Integer) session.getAttribute("userId");
            } else if (session != null && session.getAttribute("user") != null) {
                String usernameOrEmail = (String) session.getAttribute("user");
                userId = db.getUserId(usernameOrEmail);
            }

            System.out.println("LOG -> Final UserId for Customer Table Insertion: " + userId);

            // 3. Cart ke items ko Ek String mein Combine Karein
            StringBuilder productsDetail = new StringBuilder();
            List<Map<String, Object>> cart = null;
            if (session != null) {
                cart = (List<Map<String, Object>>) session.getAttribute("cart");
            }

            if (cart != null && !cart.isEmpty()) {
                for (Map<String, Object> item : cart) {
                    // Safety checks for cart key names
                    Object name = item.get("medicineName") != null ? item.get("medicineName") : item.get("name");
                    Object qty = item.get("quantity") != null ? item.get("quantity") : item.get("qty");
                    Object price = item.get("price");

                    productsDetail.append(name)
                            .append(" (Qty: ").append(qty)
                            .append(", Price: ₹").append(price).append("); ");
                }
            } else {
                productsDetail.append("No Products Recorded");
            }

            // 4. Save Record in Customer Table
            int customerId = db.addCustomer(userId, fullName, mobileNumber, pincode, locality, address,
                    landmark, city, state, addressType,
                    paymentAmount, paymentStatus, transactionId, productsDetail.toString());

            if (customerId != -1) {
                if (session != null) {
                    session.removeAttribute("cart"); // Cart Clear
                    session.setAttribute("customerId", customerId);
                }
                resp.sendRedirect("successPage.jsp");
            } else {
                resp.sendRedirect("payment.jsp?error=database_fail");
            }

        } catch (Exception e) {
            System.out.println("EXCEPTION IN HandleOrder SERVLET: " + e.getMessage());
            e.printStackTrace();
            resp.sendRedirect("payment.jsp?error=servlet_exception");
        } finally {
            db.close();
        }
    }
}