<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Orders Management</title>
<link rel="stylesheet" href="orderPage.css">
</head>
<body>

<div class="container">

    <!-- Sidebar -->
    <div class="sidebar">

        <div class="logo">
            <img src="images/logoProduct.png">
        </div>

        <h4>MENU</h4>

         <ul>
           <li><a href="productPage.jsp">📦 Product</a></li>
           <li><a href="orderPage.jsp">🛒 Orders</a></li>
           <li><a href="manageAdmin.jsp">👑 Admin</a></li>
         </ul>

        <div class="home">
          <a href="homePage.jsp">← Back to Home</a>
        </div>

    </div>

    <!-- Main Content -->

    <div class="main">

        <div class="topbar">
            <h2>Orders Management</h2>
        </div>

       <form action="order" method="post">
         <div class="table-box">

            <h3>Orders List</h3>

            <table>

                <tr>
                    <th>ID</th>
                    <th>Full Name</th>
                    <th>Mobile</th>
                    <th>Pincode</th>
                    <th>Locality</th>
                    <th>Address</th>
                    <th>Landmark</th>
                    <th>City</th>
                    <th>State</th>
                    <th>Type</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Transaction ID</th>
                </tr>

                 <%@ page import="DB.HandleDatabase,java.sql.*" %>
                             <%
                                HandleDatabase db = new HandleDatabase();
                                ResultSet rs = db.order();
                                if(rs != null) {
                                    while(rs.next()){

                                        // Safely fetching payment & transaction details
                                        String paymentAmount = rs.getString("payment_amount") != null ? rs.getString("payment_amount") : "0.00";
                                        String paymentStatus = rs.getString("payment_status") != null ? rs.getString("payment_status") : "Pending";

                                        String transactionId = "-";
                                        try {
                                            transactionId = rs.getString("transaction_id");
                                            if(transactionId == null || transactionId.trim().isEmpty()) {
                                                transactionId = "-";
                                            }
                                        } catch(Exception e) {
                                            transactionId = "-";
                                        }
                             %>

                <tr>
                      <td><%= rs.getInt("id") %></td>
                      <td><%= rs.getString("fullName") != null ? rs.getString("fullName") : "-" %></td>
                      <td><%= rs.getString("mobileNumber") != null ? rs.getString("mobileNumber") : "-" %></td>
                      <td><%= rs.getString("pincode") != null ? rs.getString("pincode") : "-" %></td>
                      <td><%= rs.getString("locality") != null ? rs.getString("locality") : "-" %></td>
                      <td><%= rs.getString("address") != null ? rs.getString("address") : "-" %></td>
                      <td><%= rs.getString("landmark") != null ? rs.getString("landmark") : "-" %></td>
                      <td><%= rs.getString("city") != null ? rs.getString("city") : "-" %></td>
                      <td><%= rs.getString("state") != null ? rs.getString("state") : "-" %></td>
                      <td><%= rs.getString("addressType") != null ? rs.getString("addressType") : "-" %></td>

                      <!-- Payment Details -->
                      <td>₹<%= paymentAmount %></td>
                      <td><b><%= paymentStatus %></b></td>
                      <td><%= transactionId %></td>
                </tr>

                <%
                                    }
                                    rs.close();
                                }
                                db.close();
                %>

            </table>
         </div>
       </form>

    </div>

</div>

</body>
</html>