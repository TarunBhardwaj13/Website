<!DOCTYPE html>
<html>
<head>
    <title>Avantika Medical Store - Login</title>
    <link rel="stylesheet" href="index.css">
</head>
<body>

<div class="container">

    <!-- Left Side Image -->
    <div class="leftSide">
        <img src="images/left-side .png" alt="Medical Store" width="100%" height="100%">
    </div>

    <!-- Right Side Login Form -->
    <div class="rightSide">

        <h1><span style="color: green;">AVANTIKA</span> MEDICAL STORE</h1>
        <h2>Login</h2>

        <p>Welcome Back! Please login to your account.</p>

        <form id="loginForm" method="post" action="login">

            <input class="Username"
                   type="text"
                   name="user_email"
                   placeholder="Enter Username or Email"
                   required>

            <input class="Password"
                   type="password"
                   name="password"
                   placeholder="Enter your Password"
                   required>

            <div class="options">
                <label>
                    <input type="checkbox"> Remember Me
                </label>

                <a href="forgot.jsp">Forgot Password?</a>
            </div>

            <button type="submit">Login</button>

            <p style="margin-top:20px;">
                Don't have an account?
                <a href="signUp.jsp">Sign Up</a>
            </p>

        </form>

    </div>

</div>

</body>
</html>