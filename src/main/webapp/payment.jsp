<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="stylesheet" href="payment.css">
    <style>
        .qrSection, .paymentNote, .transactionBox { display: none; }
    </style>
</head>
<body>

<%@ page import="DB.HandleDatabase,java.sql.*" %>

<%
    String medicineName = request.getParameter("medicineName");
    HandleDatabase db = new HandleDatabase();

    String price = "0";
    String offer = "0";
    String medName = "Medicine Order";
    String companyName = "";
    String imageName = "default.png";

    if(medicineName != null && !medicineName.trim().isEmpty()){
        ResultSet rs = db.productWiseMedicineList(medicineName);
        if(rs != null && rs.next()){
            price = rs.getString("price");
            offer = rs.getString("offer");
            medName = rs.getString("medicineName");
            companyName = rs.getString("companyName");
            imageName = rs.getString("image");
        }
    }
%>

<form action="order" method="post">

    <!-- Hidden Inputs for Address & Order Data -->
    <input type="hidden" name="fullName" value="<%= request.getParameter("fullName") != null ? request.getParameter("fullName") : "" %>">
    <input type="hidden" name="mobileNumber" value="<%= request.getParameter("mobileNumber") != null ? request.getParameter("mobileNumber") : "" %>">
    <input type="hidden" name="pincode" value="<%= request.getParameter("pincode") != null ? request.getParameter("pincode") : "" %>">
    <input type="hidden" name="locality" value="<%= request.getParameter("locality") != null ? request.getParameter("locality") : "" %>">
    <input type="hidden" name="address" value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
    <input type="hidden" name="landmark" value="<%= request.getParameter("landmark") != null ? request.getParameter("landmark") : "" %>">
    <input type="hidden" name="city" value="<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>">
    <input type="hidden" name="state" value="<%= request.getParameter("state") != null ? request.getParameter("state") : "" %>">
    <input type="hidden" name="addressType" value="<%= request.getParameter("addressType") != null ? request.getParameter("addressType") : "" %>">

    <input type="hidden" name="medicineName" value="<%= medName %>">
    <input type="hidden" name="payment_amount" id="hiddenTotal" value="0.00">
    <input type="hidden" name="payment_status" id="paymentStatus" value="Cash On Delivery">

    <div class="container">

        <!-- ================= LEFT SIDE ================= -->
        <div class="leftContainer">
            <a href="buyPage.jsp?medicineName=<%= medName %>" class="backBtn">
               <img src="images/left.png" alt="back"> Back to Delivery Details
            </a>

            <h1>Payment Method</h1>
            <p class="subTitle">Select a payment option to place your order</p>

            <!-- COD -->
            <div class="paymentBox">
                <label>
                    <input type="radio" name="paymentMethod" value="Cash On Delivery" checked onclick="updatePaymentType('Cash On Delivery', false)">
                    <div class="paymentContent">
                        <h2>Cash on Delivery (COD)</h2>
                        <p>Pay when your order is delivered to your doorstep.</p>
                    </div>
                </label>
            </div>

            <!-- QR PAYMENT -->
            <div class="paymentBox">
                <label>
                    <input type="radio" name="paymentMethod" value="QR Payment" onclick="updatePaymentType('QR Payment', true)">
                    <div class="paymentContent">
                        <h2>Scan QR & Pay</h2>
                        <p>Scan the QR code using any UPI App and complete the payment.</p>
                    </div>
                </label>

                <div class="qrSection" id="qrSection">
                    <img src="images/QR.png" class="qrImage" alt="QR Code">
                    <div class="upiDetails">
                        <h3>UPI ID</h3>
                        <p>avantikamedical@upi</p>
                        <br>
                        <h3>Mobile Number</h3>
                        <p>+91 9410037403</p>
                    </div>
                </div>

                <div class="paymentNote" id="paymentNote">
                    <p>After completing payment, please keep the payment screenshot.</p>
                </div>

                <div class="transactionBox" id="transactionBox">
                    <label>Transaction ID / UTR</label>
                    <input type="text" name="transactionId" id="transactionId" placeholder="Enter UTR / Transaction ID">
                </div>
            </div>

            <button type="submit" class="placeOrderBtn">Place Order</button>
        </div>

        <!-- ================= RIGHT SIDE ================= -->
        <div class="rightContainer">
            <div class="orderSummary">
                <div class="summaryHeader">
                    <h2><img src="images/order.png" alt="order"> Order Summary</h2>
                    <span><span id="quantity">1</span> Item</span>
                </div>
                <hr>

                <div class="productBox">
                    <img src="image/<%= imageName %>" class="medicineImage" alt="medicine">
                    <div class="productInfo">
                        <h3><%= medName %></h3>
                        <p><%= companyName %></p>
                    </div>
                </div>
                <hr>

                <div class="amountRow">
                    <span>MRP</span>
                    <span><img src="images/rupee.png" alt="rupee"> <%= price %></span>
                </div>

                <div class="amountRow">
                    <span>Discount</span>
                    <span class="green">- <%= offer %>%</span>
                </div>

                <div class="amountRow">
                    <span>Delivery Charges</span>
                    <span class="green">FREE</span>
                </div>
                <hr>

                <div class="totalRow">
                    <h2>Total Amount</h2>
                    <h2 class="green">
                       <b style="color:green;">
                         <img src="images/rupee.png" alt="rupee">
                         <span id="totalPrice">0.00</span>
                       </b>
                    </h2>
                </div>
            </div>

            <div class="paymentInfo">
                <div class="infoBox secureBox">
                    <div class="icon"><img src="images/verification.png" alt="secure"></div>
                    <div>
                        <h4>Safe & Secure Payments</h4>
                        <p>Your payment details are protected with 256-bit SSL encryption.</p>
                    </div>
                </div>
            </div>
        </div>

    </div>
</form>

<% db.close(); %>

<script>
    var qty = parseInt(localStorage.getItem("qty")) || 1;
    var rate = parseFloat("<%= price %>") || 0;
    var offer = parseFloat("<%= offer %>") || 0;

    var finalPrice = (qty * rate) - ((qty * rate) * offer / 100);

    document.getElementById('quantity').textContent = qty;
    document.getElementById('totalPrice').textContent = finalPrice.toFixed(2);
    document.getElementById('hiddenTotal').value = finalPrice.toFixed(2);

    function updatePaymentType(type, isQR) {
        document.getElementById('paymentStatus').value = type;

        var displayVal = isQR ? 'block' : 'none';
        document.getElementById('qrSection').style.display = displayVal;
        document.getElementById('paymentNote').style.display = displayVal;
        document.getElementById('transactionBox').style.display = displayVal;

        if(!isQR) {
            document.getElementById('transactionId').value = "";
        }
    }
</script>

</body>
</html>