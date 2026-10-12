<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="DB.HandleDatabase" %>

<%
    Boolean isAdmin = (Boolean)session.getAttribute("isAdmin");

    if(isAdmin == null || !isAdmin){
        response.sendRedirect("homePage.jsp");
        return;
    }

    HandleDatabase db = new HandleDatabase();

    ResultSet adminList = db.adminList();
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <title>Manage Admin</title>

    <link rel="stylesheet" href="manageAdmin.css">

</head>
<body>

<div class="container">

    <!--================ Sidebar =================-->

<div class="sidebar">

    <!-- Logo Section -->
    <div class="logo">
        <img src="images/logoProduct.png" alt="Avantika Medical Logo">
    </div>

    <h2>MENU</h2>

    <a href="productPage.jsp">
        📦 Product
    </a>

    <a href="orderPage.jsp">
        🛒 Orders
    </a>

    <a href="manageAdmin.jsp" class="active">
        👑 Manage Admin
    </a>

    <!-- Bottom Back to Home Link -->
    <div class="home">
        <a href="homePage.jsp">← Back to Home</a>
    </div>

</div>


    <!--================ Right Section =================-->

    <div class="content">


        <div class="title">

            <h1>👥 Manage Admins</h1>

            <p>
                Search user by username or email and give/remove admin access.
            </p>

        </div>


        <!--================ Search =================-->

        <div class="searchBox">

            <form action="manageAdmin.jsp" method="get">

                <input
                        type="text"
                        name="search"
                        placeholder="Search by Username or Email">

                <button>

                    🔍 Search

                </button>

            </form>

        </div>



        <!--================ Search Result =================-->

        <div class="card">

            <h2>Search Result</h2>

            <table>

                <tr>

                    <th>ID</th>

                    <th>Name</th>

                    <th>Username</th>

                    <th>Email</th>

                    <th>Status</th>

                    <th>Action</th>

                </tr>

                <%

                    String search=request.getParameter("search");

                    if(search!=null && !search.trim().equals("")){

                        ResultSet rs=db.searchUser(search);

                        while(rs.next()){

                %>

                <tr>

                    <td><%=rs.getInt("id")%></td>

                    <td><%=rs.getString("name")%></td>

                    <td><%=rs.getString("username")%></td>

                    <td><%=rs.getString("email")%></td>

                    <td>

                        <%

                            if(db.isAdmin(rs.getInt("id"))){

                        %>

                        <span class="adminStatus">

                            Admin

                        </span>

                        <%

                            }else{

                        %>

                        <span class="notAdmin">

                            Not Admin

                        </span>

                        <%

                            }

                        %>

                    </td>

                    <td>

                        <form action="handleAdmin" method="post">

                            <input
                                    type="hidden"
                                    name="userId"
                                    value="<%=rs.getInt("id")%>">

                            <%

                                if(db.isAdmin(rs.getInt("id"))){

                            %>

                            <button
                                    class="removeBtn"
                                    name="action"
                                    value="remove">

                                Remove Admin

                            </button>

                            <%

                                }else{

                            %>

                            <button
                                    class="addBtn"
                                    name="action"
                                    value="make">

                                Add Admin

                            </button>

                            <%

                                }

                            %>

                        </form>

                    </td>

                </tr>

                <%

                        }

                    }

                %>

            </table>

        </div>




        <!--================ Current Admin =================-->

        <div class="card">

            <h2>Current Admins</h2>

            <table>

                <tr>

                    <th>ID</th>

                    <th>Name</th>

                    <th>Username</th>

                    <th>Email</th>

                    <th>Action</th>

                </tr>

                <%

                    while(adminList.next()){

                %>

                <tr>

                    <td>

                        <%=adminList.getInt("id")%>

                    </td>

                    <td>

                        <%=adminList.getString("name")%>

                    </td>

                    <td>

                        <%=adminList.getString("username")%>

                    </td>

                    <td>

                        <%=adminList.getString("email")%>

                    </td>

                    <td>

                        <form action="handleAdmin" method="post">

                            <input
                                    type="hidden"
                                    name="userId"
                                    value="<%=adminList.getInt("id")%>">

                            <button
                                    class="removeBtn"
                                    name="action"
                                    value="remove">

                                Remove Admin

                            </button>

                        </form>

                    </td>

                </tr>

                <%

                    }

                %>

            </table>

        </div>

    </div>

</div>

</body>
</html>