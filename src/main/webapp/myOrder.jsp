<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>My Order History - Avantika Medical Store</title>
    <style>
        /* Body Normalization */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f9;
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Order Section Container (Centered) */
        .main-content {
            max-width: 1000px;
            margin: 0 auto;
            padding: 0 20px 40px 20px;
        }

        /* Title Styling */
        .page-title {
            font-size: 24px;
            font-weight: bold;
            color: #222;
            margin-bottom: 20px;
            border-bottom: 2px solid #2e7d32;
            padding-bottom: 8px;
            display: inline-block;
        }

        /* Order Card Layout */
        .order-card {
            background: #ffffff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.06);
            border: 1px solid #e2e8f0;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid #edf2f7;
            padding-bottom: 12px;
            margin-bottom: 12px;
        }

        .status {
            background: #e0f2fe;
            color: #0369a1;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            display: inline-block;
        }

        .item-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px dashed #e2e8f0;
        }

        .item-row:last-child {
            border-bottom: none;
        }

        .item-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .item-img {
            width: 55px;
            height: 55px;
            object-fit: cover;
            border-radius: 6px;
            border: 1px solid #ddd;
        }

        .no-history {
            background: #ffffff;
            padding: 40px;
            text-align: center;
            border-radius: 8px;
            color: #666;
            box-shadow: 0 2px 6px rgba(0,0,0,0.05);
        }
    </style>
</head>
<body>

    <!-- 1. FULL WIDTH HEADER CONTAINER -->
    <div class="full-width-header">
        <jsp:include page="header.jsp" />
    </div>

    <!-- 2. MAIN CONTENT AREA (Centered & Organized) -->
    <div class="main-content">
        <h2 class="page-title">My Order History</h2>

        <%
            List<Map<String, Object>> ordersList = (List<Map<String, Object>>) request.getAttribute("ordersList");
            if (ordersList == null || ordersList.isEmpty()) {
        %>
            <div class="no-history">
                <img src="https://cdn-icons-png.flaticon.com/512/4076/4076478.png" width="80" style="opacity: 0.5; margin-bottom: 10px;" />
                <h3>No Orders Found</h3>
                <p>Aapne abhi tak koi order place nahi kiya hai.</p>
            </div>
        <%
            } else {
                for (Map<String, Object> order : ordersList) {
        %>
            <div class="order-card">
                <div class="order-header">
                    <div>
                        <strong style="font-size: 16px;">Order #<%= order.get("orderId") %></strong>
                        <div style="font-size: 13px; color: #718096; margin-top: 3px;">Date: <%= order.get("createdAt") %></div>
                    </div>
                    <div style="text-align: right;">
                        <span class="status"><%= order.get("status") %></span>
                        <div style="font-weight: bold; font-size: 16px; margin-top: 6px; color: #2e7d32;">Total: ₹<%= order.get("totalAmount") %></div>
                    </div>
                </div>

                <h4 style="margin: 10px 0; color: #4a5568;">Items Purchased:</h4>
                <%
                    List<Map<String, Object>> items = (List<Map<String, Object>>) order.get("items");
                    if (items != null) {
                        for (Map<String, Object> item : items) {
                            double price = item.get("price") != null ? Double.parseDouble(item.get("price").toString()) : 0.0;
                            int quantity = item.get("quantity") != null ? Integer.parseInt(item.get("quantity").toString()) : 0;
                %>
                    <div class="item-row">
                        <div class="item-info">
                            <% if (item.get("image") != null && !item.get("image").toString().trim().isEmpty()) { %>
                                <img src="<%= item.get("image") %>" class="item-img" alt="medicine" />
                            <% } else { %>
                                <div class="item-img" style="background:#edf2f7; display:flex; align-items:center; justify-content:center; font-size:10px; color:#a0aec0;">No Image</div>
                            <% } %>
                            <div>
                                <strong style="color: #2d3748;"><%= item.get("medicineName") %></strong><br>
                                <small style="color: #718096;">Qty: <%= quantity %> | Unit Price: ₹<%= price %></small>
                            </div>
                        </div>
                        <div style="font-weight: bold; color: #2d3748;">₹<%= price * quantity %></div>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        <%
                }
            }
        %>
    </div>

</body>
</html>