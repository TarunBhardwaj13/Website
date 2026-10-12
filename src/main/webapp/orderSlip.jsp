<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DB.HandleDatabase,java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Orders & History</title>
    <style>
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f4f7f6; padding: 20px; }
        .page-title { text-align: center; color: #00695c; margin-bottom: 25px; }

        /* Order Card Layout */
        .slip-box { max-width: 550px; margin: 0 auto 25px auto; background: white; padding: 25px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .header { text-align: center; border-bottom: 2px dashed #ddd; padding-bottom: 15px; }
        .header h2 { margin: 0; color: #00695c; font-size: 20px; }
        .status-badge { display: inline-block; padding: 5px 12px; border-radius: 15px; font-weight: bold; font-size: 13px; margin-top: 5px; }

        /* Status Badges Colors */
        .cod { background: #e3f2fd; color: #1565c0; }
        .qr { background: #e8f5e9; color: #2e7d32; }
        .cancelled-badge { background: #ffebee; color: #c62828; }

        .row { display: flex; justify-content: space-between; margin: 10px 0; font-size: 14px; }
        .label { color: #666; }
        .value { font-weight: 600; color: #333; text-align: right; }
        .hr-line { border: none; border-top: 1px solid #eee; margin: 15px 0; }

        /* Action Buttons */
        .btn-container { display: flex; gap: 10px; margin-top: 15px; }
        .btn { flex: 1; padding: 9px; text-align: center; border-radius: 5px; font-weight: bold; text-decoration: none; border: none; cursor: pointer; font-size: 13px; }
        .print-btn { background: #00695c; color: white; }
        .cancel-btn { background: #d32f2f; color: white; }
        .disabled-btn { background: #e0e0e0; color: #757575; cursor: not-allowed; flex: 1; text-align: center; padding: 9px; border-radius: 5px; font-weight: bold; font-size: 13px; }

        .no-orders { text-align: center; background: white; max-width: 400px; margin: 50px auto; padding: 30px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.08); }
    </style>
</head>
<body>

<h2 class="page-title">📦 My Order History</h2>

<%
    HandleDatabase db = new HandleDatabase();
    Connection conn = db.getConnection();

    // 1. Handle Cancel Order
    String cancelId = request.getParameter("cancelId");
    if (cancelId != null && !cancelId.trim().isEmpty()) {
        try {
            PreparedStatement psCancel = conn.prepareStatement("UPDATE customer SET payment_status='Cancelled' WHERE id=?");
            psCancel.setInt(1, Integer.parseInt(cancelId));
            psCancel.executeUpdate();
            psCancel.close();
            out.println("<script>alert('Order #" + cancelId + " cancelled successfully!'); window.location.href='orderSlip.jsp';</script>");
        } catch (Exception e) {
            out.println("<script>alert('Error: " + e.getMessage() + "');</script>");
        }
    }

    // 2. Fetch ALL Orders for User (Newest First)
    Integer customerId = (Integer) session.getAttribute("customerId");
    String mobileNumber = (String) session.getAttribute("mobileNumber"); // Session se mobile match kar sakein

    String sql = "SELECT * FROM customer ORDER BY id DESC"; // Fetch all orders in descending order
    if (customerId != null) {
        sql = "SELECT * FROM customer WHERE id = " + customerId + " ORDER BY id DESC";
    }

    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery(sql);

    boolean hasOrders = false;

    // WHILE LOOP FOR MULTIPLE ORDERS
    while(rs.next()){
        hasOrders = true;
        int orderId = rs.getInt("id");
        String paymentStatus = rs.getString("payment_status");
        String txnId = rs.getString("transaction_id");

        boolean isCancelled = "Cancelled".equalsIgnoreCase(paymentStatus);
%>

<!-- Order Card -->
<div class="slip-box">
    <div class="header">
        <h2>Avantika Medical Store</h2>
        <p style="margin: 3px 0; color:#777; font-size:12px;">Order Summary & Receipt</p>

        <!-- Status Badge -->
        <% if (isCancelled) { %>
            <span class="status-badge cancelled-badge">Status: Cancelled</span>
        <% } else { %>
            <span class="status-badge <%= "Cash On Delivery".equalsIgnoreCase(paymentStatus) ? "cod" : "qr" %>">
                Status: <%= paymentStatus != null ? paymentStatus : "Submitted" %>
            </span>
        <% } %>
    </div>

    <div class="hr-line"></div>

    <div class="row">
        <span class="label">Order ID:</span>
        <span class="value">#ORD-<%= orderId %></span>
    </div>
    <div class="row">
        <span class="label">Customer Name:</span>
        <span class="value"><%= rs.getString("fullName") %></span>
    </div>
    <div class="row">
        <span class="label">Mobile:</span>
        <span class="value"><%= rs.getString("mobileNumber") %></span>
    </div>
    <div class="row">
        <span class="label">Delivery Address:</span>
        <span class="value"><%= rs.getString("address") %>, <%= rs.getString("city") %> (<%= rs.getString("pincode") %>)</span>
    </div>

    <div class="hr-line"></div>

    <div class="row">
        <span class="label">Payment Mode:</span>
        <span class="value"><%= paymentStatus %></span>
    </div>

    <% if(txnId != null && !txnId.equals("-")) { %>
    <div class="row">
        <span class="label">Transaction ID / UTR:</span>
        <span class="value"><%= txnId %></span>
    </div>
    <% } %>

    <div class="row">
        <span class="label">Delivery Status:</span>
        <span class="value" style="color: <%= isCancelled ? "#d32f2f" : "#ef6c00" %>;">
            <%= isCancelled ? "Order Cancelled" : "Processing / On the way" %>
        </span>
    </div>

    <div class="row" style="font-size: 16px; margin-top: 15px;">
        <span class="label" style="font-weight: bold; color: #333;">Total Amount:</span>
        <span class="value" style="color: #2e7d32;">₹<%= rs.getString("payment_amount") %></span>
    </div>

    <div class="hr-line"></div>

    <!-- Buttons -->
    <div class="btn-container">
        <button onclick="window.print()" class="btn print-btn">🖨️ Print Receipt</button>

        <% if (!isCancelled) { %>
            <a href="orderSlip.jsp?cancelId=<%= orderId %>"
               onclick="return confirm('Are you sure you want to cancel Order #<%= orderId %>?');"
               class="btn cancel-btn">
               ❌ Cancel Order
            </a>
        <% } else { %>
            <div class="disabled-btn">Order Cancelled</div>
        <% } %>
    </div>
</div>

<%
    } // End of While Loop

    if (!hasOrders) {
%>
    <div class="no-orders">
        <h3>No Orders Found!</h3>
        <p style="color:#666; font-size:14px;">Aapne abhi tak koi order place nahi kiya hai.</p>
        <a href="homePage.jsp" style="color:#00695c; font-weight:bold; text-decoration:none;">Go to Shopping →</a>
    </div>
<%
    }
    st.close();
    db.close();
%>

<div style="text-align:center; margin: 20px 0;">
    <a href="homePage.jsp" style="color:#00695c; text-decoration:none; font-weight:bold; font-size:14px;">← Back to Home Page</a>
</div>

</body>
</html>