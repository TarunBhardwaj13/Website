<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delivery Details</title>

    <link rel="stylesheet" href="buyPage.css">
</head>

<body>

     <%@ page import="DB.HandleDatabase,java.sql.*" %>

     <%
        String medicineName = request.getParameter("medicineName");

        HandleDatabase db = new HandleDatabase();
        ResultSet rs = db.productWiseMedicineList(medicineName);

        if(rs != null && rs.next()){
     %>

 <div class="container">

       <%@ include file="header.jsp" %>
     <form action="payment.jsp" method="get" class="checkoutFrom">

        <!-- 🔴 FIX: Missing Hidden Field Added Below 🔴 -->
        <input type="hidden" name="medicineName" value="<%= rs.getString("medicineName") %>">

        <div class="leftContainer">

           <h2><img src="images/travel.png" alt="travel"> Delivery Details</h2>

           <hr>

           <h3>Delivery Address</h3>

                 <div class="row">

                     <div class="inputBox">
                         <label>Full Name <span>*</span></label>
                         <input type="text" name="fullName" placeholder="Enter your full name" required>
                     </div>

                     <div class="inputBox">
                         <label>Mobile Number <span>*</span></label>
                         <input type="text" name="mobileNumber" placeholder="Enter your mobile number" required>
                     </div>

                 </div>

                 <div class="row">

                     <div class="inputBox">
                         <label>Pincode <span>*</span></label>
                         <input type="text" name="pincode" placeholder="Enter pincode" required>
                     </div>

                     <div class="inputBox">
                         <label>Locality / Area <span>*</span></label>
                         <input type="text" name="locality" placeholder="Enter locality or area" required>
                     </div>

                 </div>

                 <div class="row">

                     <div class="inputBox">
                         <label>Address (House No., Building, Street) <span>*</span></label>
                         <input type="text" name="address" placeholder="Enter complete address" required>
                     </div>

                     <div class="inputBox">
                         <label>Landmark (Optional)</label>
                         <input type="text" name="landmark" placeholder="Enter landmark">
                     </div>

                 </div>

                 <div class="row">

                     <div class="inputBox">
                         <label>City <span>*</span></label>
                         <input type="text" name="city" placeholder="Enter city" required>
                     </div>

                     <div class="inputBox">

                         <label>Address Type</label>

                         <div class="radioGroup">

                             <label>
                                 <input type="radio" name="addressType" value="Home" checked>
                                 Home
                             </label>

                             <label>
                                 <input type="radio" name="addressType" value="Work">
                                 Work
                             </label>

                         </div>

                     </div>

                 </div>

                 <div class="saveAddress">

                     <label>
                         <input type="checkbox" name="saveAddress">
                         Save this address for future use
                     </label>

                 </div>

                 <h3>Delivery Options</h3>

                 <div class="deliveryOption">

                     <div>
                         <h4><img src="images/van.png" alt="van"> Standard Delivery</h4>
                         <p>Delivery in 1-2 days</p>
                     </div>

                     <span>FREE</span>

                  </div>

                 <button type="submit" class="continueBtn">
                     CONTINUE TO PAYMENT
                 </button>

       </div>

       <div class="rightContainer">

           <!-- Order Summary -->

           <div class="orderSummary">

               <div class="summaryHeader">

                   <h3><img src="images/order.png" alt="order"> Order Summary</h3>

                   <span><span id="quantity">1</span> Item</span>
               </div>

               <div class="productBox">

                   <img src="image/<%=rs.getString("image")%>" class="medicineImage" alt="medicine">

                   <div class="productDetails">
                       <h4><%=rs.getString("medicineName")%></h4>
                       <p><%=rs.getString("companyName")%></p>
                   </div>

                   <div class="productPrice">
                      <span id="price"></span>
                   </div>

               </div>

               <hr>

               <div class="amountRow">
                   <span>MRP</span>
                   <span><img src="images/rupee.png" alt="rupee"><%=rs.getString("price")%></span>
               </div>

               <div class="amountRow">
                   <span>Discount</span>
                   <span style="color:green;">
                       - <%=rs.getString("offer")%>%
                   </span>
               </div>

               <div class="amountRow">
                   <span>Delivery Charges</span>
                   <span style="color:green;">FREE</span>
               </div>

               <hr>

               <div class="totalRow">

                   <b>Total Amount</b>

                   <b style="color:green;">
                      <img src="images/rupee.png" alt="rupee">
                      <span id="totalPrice">0.00</span>
                   </b>

                   <script>
                    var qty = parseInt(localStorage.getItem("qty")) || 1;
                    var rate = parseFloat("<%= rs.getString("price") %>") || 0;
                    var offer = parseFloat("<%= rs.getString("offer") %>") || 0;

                    var finalPrice = (qty * rate) - ((qty * rate) * offer / 100);

                    document.getElementById('quantity').textContent = qty;
                    document.getElementById('totalPrice').textContent = finalPrice.toFixed(2);
                   </script>

               </div>

               <div class="securePayment">
                   <img src="images/verification.png" alt="secure"> Safe & Secure Payments
                   <p>Your payment details are protected.</p>
               </div>

           </div>

       </div>

       <%
       }
       db.close();
       %>

     </form>
 </div>

</body>
</html>