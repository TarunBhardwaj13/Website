<html>
<head>
    <link rel="stylesheet" href="index.css">
</head>
<body>

<div class="container">

    <div class="leftSide">
        <img src="images/left-side .png" width="100%" height="100%">
    </div>

    <div class="rightSide">
        <h1 style="color: #009688;">Welcome to Avantika Medical Store</h1>
        <p><i>Create your account and start shopping for healthcare products</i></p>

        <form id="signupForm" action="signup" method="post">

            <input class="Name" type="text"
                   placeholder="Full Name"
                   name="name">

            <input class="Username" type="text"
                   placeholder="Username"
                   name="username">

            <input class="email" type="email"
                   placeholder="Email Address"
                   name="email">

            <input class="Password" type="password"
                   placeholder="Password"
                   name="password">

            <button type="submit">Sign Up</button>
            <br><br>

            <p>
                Already have an account?
                <a href="index.jsp">Back to Login</a>
            </p>

        </form>
    </div>

</div>

</body>
</html>