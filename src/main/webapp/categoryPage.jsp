<%@ page import="DB.HandleDatabase,java.sql.*" %>

<html>
<head>
<title>it is category page</title>
<link rel="stylesheet" href="categoryPage.css">
</head>
<body>

<div class="container">
      <%@ include file="header.jsp" %>

      <div class="mid">

        <!-- Left Sidebar -->
        <div class="sidebar">

            <!-- Categories -->
            <div class="sidebar-box">

                <h3>CATEGORIES</h3>

                <ul class="category-list">



                    <li class="active"><a href="categoryPage.jsp">All Medicines</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Pain Relief">Pain Relief</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Fever">Fever</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Cold &amp; Cough">Cold &amp; Cough</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Antibiotics">Antibiotics</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Vitamins & amp; supplements">Vitamins &amp; Supplements</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Diabetes Care">Diabetes Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Heart Care">Heart Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Digestive Care">Digestive Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Skin Care">Skin Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Eye Care">Eye Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Women Care">Women Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Baby Care">Baby Care</a></li>

                    <li><a href="categoryPage.jsp?type=uses&name=Other Medicines">Other Medicines</a></li>

                </ul>

            </div>

            <!-- Price Range -->
            <div class="sidebar-box">

                <h3>PRICE RANGE</h3>

                <div class="price-range">

                    <input type="range" min="10" max="500" value="500">

                    <div class="price-value">

                        <span> <img src="images/rupee.png" alt="rupee"> 10</span>

                        <span><img src="images/rupee.png" alt="rupee">500</span>

                    </div>

                    <button type="button">APPLY</button>

                </div>

            </div>

        </div>



        <!-- right side -->

        <div class="product-section">

            <!-- Header -->
            <div class="product-header">

                <div>
                   <%
                    String type = request.getParameter("type");
                    String name = request.getParameter("name"); %>
                      <h1><%= name %></h1>




                    <p>Showing Medicines</p>
                </div>

                <div class="sort-box">
                    <select>
                        <option>Sort by: Popularity</option>
                        <option>Price Low to High</option>
                        <option>Price High to Low</option>
                        <option>Newest</option>
                    </select>
                </div>

            </div>

         <div class= " medicineimages">
                   <table>
                       <%  HandleDatabase db = new HandleDatabase();

                       ResultSet rs = db.usesWiseMedicineList(type, name);
                       while(rs.next()){ %>
                       <table>
                       <tr>
                           <td><img src="image/<%= rs.getString("image") %>" width="150px" height="150px"></td>
                           <td><%= rs.getString(1) %></td>
                           <td><%= rs.getString(2) %></td>
                          <!-- <td><%= rs.getString(3) %></td>
                           <td><%= rs.getString(4) %></td>
                           <td><%= rs.getString(5) %></td>
                           <td><%= rs.getString(6) %></td>
                           <td><%= rs.getString(7) %></td>-->
                           <td><%= rs.getString(9) %></td>

                           <td>
                               <a href="productDetails.jsp?medicineName=<%=rs.getString("medicineName") %>" class="view-btn">
                                   View More
                               </a>
                           </td>

                       </tr>
                       <% } %>
                    </table>


         </div>
        </div>
      </div>


        <!-- Feature Section Start    footer part  -->

        <section class="feature-section">

            <div class="feature-box">

                <div class="feature-icon">
                    <i class="fa-solid fa-shield-heart"></i>
                </div>

                <div class="feature-text">
                    <h3>100% Genuine Products</h3>
                    <p>Quality you can trust</p>
                </div>

            </div>

            <div class="feature-box">

                <div class="feature-icon">
                    <i class="fa-solid fa-truck"></i>
                </div>

                <div class="feature-text">
                    <h3>Fast & Secure Delivery</h3>
                    <p>On time, every time</p>
                </div>

            </div>

            <div class="feature-box">

                <div class="feature-icon">
                    <i class="fa-regular fa-credit-card"></i>
                </div>

                <div class="feature-text">
                    <h3>Secure Payments</h3>
                    <p>Safe & Secure Transactions</p>
                </div>

            </div>

            <div class="feature-box">

                <div class="feature-icon">
                    <i class="fa-solid fa-headset"></i>
                </div>

                <div class="feature-text">
                    <h3>24/7 Customer Support</h3>
                    <p>We're here to help</p>
                </div>

            </div>

        </section>

        <!-- Font Awesome -->
        <link rel="stylesheet"
        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</div>
    </body>
</form>