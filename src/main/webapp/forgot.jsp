<!DOCTYPE html>
<html>
<head>
    <title>Avantika Medical Store</title>
    <link rel="stylesheet" href="forgot.css">

    <!-- Font Awesome -->
    <link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>


<header>

    <div class="logo">

        <!-- <img src="images/logo.png" alt="Logo"> -->

        <div class="logoText">
            <h1>AVANTIKA</h1>
            <h3>MEDICAL STORE</h3>
        </div>

    </div>

    <div class="loginbtn">
       <a href="index.jsp">Login</a> /
       <a href="signUp.jsp">Signup <img src="images/avatar.png" alt="avatar"></a>
    </div>

</header>


   <div class="container">

       <!-- LEFT -->

       <div class="left">

           <h1>

               Forgot <span>Password?</span>

           </h1>

           <p>

               No worries! Enter your registered email or
               username and set a new password.

           </p>

           <img src="images/left-side .png">

       </div>



       <!-- RIGHT -->

       <div class="right">

           <div class="card">

                <%
                String success = (String) request.getAttribute("Success");
                String error = (String) request.getAttribute("Error");

                if(success != null){
                %>

                <div style="color:green;
                            background:#e8f5e9;
                            border:1px solid green;
                            padding:10px;
                            border-radius:5px;
                            margin-bottom:15px;
                            text-align:center;">
                    <%= success %>
                </div>

                <%
                } else if(error != null){
                %>

                <div style="color:red;
                            background:#fdeaea;
                            border:1px solid red;
                            padding:10px;
                            border-radius:5px;
                            margin-bottom:15px;
                            text-align:center;">
                    <%= error %>
                </div>

                <%
                }
                %>
               <div class="lock">

                   <i class="fa-solid fa-lock"></i>

               </div>

               <h2>

                   Reset Your Password

               </h2>

               <div class="line">

                   <hr>

                   <i class="fa-solid fa-leaf"></i>

                   <hr>

               </div>


               <form action="forgotPassword" method="post">

                   <label>Email Address or Username</label>

                   <div class="inputBox">

                       <i class="fa-regular fa-user"></i>

                       <input type="text"
                              name="username"
                              placeholder="Enter your email or username"
                              required>

                   </div>



                   <label>New Password</label>

                   <div class="inputBox">

                       <i class="fa-solid fa-lock"></i>

                       <input type="password"
                              name="newPassword"
                              placeholder="Enter new password"
                              required>

                       <i class="fa-regular fa-eye"></i>

                   </div>



                   <label>Confirm New Password</label>

                   <div class="inputBox">

                       <i class="fa-solid fa-lock"></i>

                       <input type="password"
                              name="confirmPassword"
                              placeholder="Confirm new password"
                              required>

                       <i class="fa-regular fa-eye"></i>

                   </div>

                       <button type="submit">
                           Reset
                       </button>
               </form>


               <div class="or">

                   <hr>

                   <span>OR</span>

                   <hr>

               </div>



               <a href="index.jsp" class="back">

                   <i class="fa-solid fa-arrow-left"></i>

                   Back to Login

               </a>

           </div>

       </div>

   </div>

   <div class="service-section">

       <div class="service-box">

           <div class="icon">
               <i class="fa-solid fa-shield-heart"></i>
           </div>

           <div class="text">
               <h3>100% Genuine</h3>
               <p>Medicines</p>
           </div>

       </div>

       <div class="divider"></div>

       <div class="service-box">

           <div class="icon">
               <i class="fa-solid fa-truck-fast"></i>
           </div>

           <div class="text">
               <h3>Fast & Safe</h3>
               <p>Delivery</p>
           </div>

       </div>

       <div class="divider"></div>

       <div class="service-box">

           <div class="icon">
               <i class="fa-solid fa-headset"></i>
           </div>

           <div class="text">
               <h3>24x7 Customer</h3>
               <p>Support</p>
           </div>

       </div>

       <div class="divider"></div>

       <div class="service-box">

           <div class="icon">
               <i class="fa-regular fa-credit-card"></i>
           </div>

           <div class="text">
               <h3>Secure</h3>
               <p>Payments</p>
           </div>

       </div>

   </div>


</body>
</html>