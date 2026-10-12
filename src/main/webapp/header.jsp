<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>
        <link rel="stylesheet" href="header.css">
  </head>

<body>

    <!-- Top Header -->
    <div class="header">

        <div class="leftheader">
            <h5> <img src="images/travel.png" alt="location"> Salawa, Sardhana, Meerut, Uttar Pradesh Near Sharkare Hospital</h5>
        </div>

        <div class="rightHeader">

            <div>
                <p> <img src="images/phone.png" alt="phone"> +91 9410037403</p>
            </div>

            <span class="divider">|</span>

           <%
               String username = (String) session.getAttribute("username");

               if(username == null){
           %>

               <a href="index.jsp">Login</a> /
               <a href="signUp.jsp">Signup <img src="images/avatar.png" alt="signup"></a>

           <%
               } else {
           %>

               <span class="user-greeting">Welcome, <b><%=username%></b></span> &nbsp;|&nbsp;

               <!-- 📋 My Orders Link (Added New) -->
               <a href="myOrder.jsp" style="color: #004d40; font-weight: bold; text-decoration: none;">
                  📋 My Orders
               </a>

           <%
               Boolean isAdmin = (Boolean) session.getAttribute("isAdmin");

               if(isAdmin != null && isAdmin){
           %>
               &nbsp;|&nbsp;
               <a href="productPage.jsp" class="adminBtn">Admin</a>
           <%
               }
           %>

               &nbsp;|&nbsp;
               <a href="indexx.jsp" class="logoutBtn" style="color: #ff5252; text-decoration: none; font-weight: bold;">Logout</a>

               <img src="images/avatar.png" alt="avatar" style="margin-left: 5px; vertical-align: middle;">

           <%
               }
           %>

        </div>

    </div>

    <!-- Search Bar -->
    <div class="searchBar">

        <div class="name">
            <a href="homePage.jsp">
                <img src="images/logo.png" alt="Avantika Medical Store">
            </a>
        </div>

        <!-- Search Form: Query ko Direct Category Page par Bhejne ke liye -->
        <form action="categoryPage.jsp" method="get" class="searchBox">
            <input type="hidden" name="type" value="search">
            <input type="text" name="name" placeholder="Search for medicines, health products..." required>

            <button type="submit">
                <img src="images/search.png" alt="search">
            </button>
        </form>

    </div>

    <!-- Navbar -->
    <div class="navbar">

        <ul>

            <li><a href="homePage.jsp">HOME</a></li>

            <li><a href="categoryPage.jsp?type=category&name=Medicine">MEDICINES</a></li>

            <li><a href="categoryPage.jsp?type=category&name=HealthCare">HEALTH CARE</a></li>

            <li><a href="categoryPage.jsp?type=category&name=PersonalCare">PERSONAL CARE</a></li>

            <li><a href="categoryPage.jsp?type=category&name=BabyCare">BABY CARE</a></li>

            <li><a href="categoryPage.jsp?type=category&name=Surgicals">SURGICALS</a></li>

            <li><a href="categoryPage.jsp?type=category&name=Wellness">WELLNESS</a></li>

            <li><a href="categoryPage.jsp?type=category&name=Offers">OFFERS</a></li>

            <li><a href="contactUs.jsp">CONTACT US</a></li>

        </ul>

    </div>

</body>
</html>