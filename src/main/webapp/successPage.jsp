<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Placed Successfully</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f7f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .success-card {
            background: white;
            padding: 40px 30px;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            text-align: center;
            max-width: 420px;
            width: 90%;
        }
        .icon-box {
            font-size: 50px;
            color: #2e7d32;
            margin-bottom: 10px;
        }
        h2 {
            color: #333;
            margin-bottom: 8px;
        }
        p {
            color: #666;
            font-size: 14px;
            line-height: 1.5;
            margin-bottom: 25px;
        }
        .btn-container {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }
        .btn {
            padding: 12px 20px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 15px;
            transition: all 0.3s ease;
        }
        .btn-view {
            background-color: #00695c;
            color: white;
        }
        .btn-view:hover {
            background-color: #004d40;
        }
        .btn-shop {
            background-color: #f1f3f4;
            color: #333;
            border: 1px solid #ccc;
        }
        .btn-shop:hover {
            background-color: #e0e0e0;
        }
    </style>
</head>
<body>

    <div class="success-card">
        <div class="icon-box">🎉</div>
        <h2>Order Placed Successfully!</h2>
        <p>Thank you for your purchase. We have received your order details.</p>

        <div class="btn-container">
            <!-- Option 1: See Order Slip -->
            <a href="orderSlip.jsp" class="btn btn-view">
               📋 See The Order / Receipt
            </a>

            <!-- Option 2: Go To Shopping -->
            <a href="homePage.jsp" class="btn btn-shop">
               🛒 Continue Shopping
            </a>
        </div>
    </div>

    <script>
        // Clear Quantity from LocalStorage after order completion
        localStorage.removeItem("qty");
    </script>

</body>
</html>