<html>
   <head>
      <title>This Is My ProductDetails Page</title>
      <link rel="stylesheet" href="productDetails.css">
   </head>
 <body>
  <div class="container">

        <%@ include file="header.jsp" %>

                  <%@ page import="DB.HandleDatabase,java.sql.*" %>

                    <%
                      String medicineName=request.getParameter("medicineName");

                      HandleDatabase db=new HandleDatabase();
                      ResultSet rs=db.productWiseMedicineList(medicineName);

                      while(rs.next()){
                    %>

                          <div class="productDetails">

                              <!-- Left Image -->
                              <div class="leftProduct">

                                  <img src="image/<%=rs.getString("image")%>" class="mainImage">

                              </div>

                              <!-- Center Details -->
                              <div class="middleProduct">

                                  <h1><%=rs.getString("medicineName")%></h1>

                                  <h3><%=rs.getString("companyName")%></h3>

                                  <div class="status">
                                      <span class="stock"><img src="images/click.png" alt="click"> In Stock</span>
                                      <span class="delivery">Delivery in 1-2 days</span>
                                  </div>

                                  <p class="description">
                                      <%=rs.getString("description")%>
                                  </p>

                                  <table class="info">

                                      <tr>
                                          <td>Salt / Composition</td>
                                          <td><%=rs.getString("salt")%></td>
                                      </tr>

                                      <tr>
                                          <td>Stock</td>
                                          <td><%=rs.getString("stock")%></td>
                                      </tr>

                                      <tr>
                                          <td>Expiry</td>
                                          <td><%=rs.getString("expiryDate")%></td>
                                      </tr>

                                      <tr>
                                          <td>Manufacturer</td>
                                          <td><%=rs.getString("companyName")%></td>
                                      </tr>

                                  </table>

                              </div>

                              <!-- Right Price Card -->
                              <div class="rightProduct">

                                  <p class="mrp">
                                      MRP
                                       <img src="images/rupee.png" alt="rupee"> <%=rs.getString("price")%>
                                  </p>

                                  <div class="discount">
                                      <%=rs.getString("offer")%>% OFF
                                  </div>

                                  <p class="save">
                                      You Save
                                      <img src="images/rupee.png" alt="rupee"><%=rs.getString("offer")%>
                                  </p>

                                  <div class="qty">

                                      <button id ="minus">-</button>

                                      <input type="text" id="qt" value="1" readonly>

                                      <button id="plus">+</button>

                                  </div>

                                    <button id="buyBtn" class="buyBtn"
                                       onclick="location.href='buyPage.jsp?medicineName=<%=rs.getString("medicineName")%>'" >
                                                 BUY NOW
                                    </button>

                                     <script>


                                     const qty = document.getElementById("qt");
                                     let quantity = qty.value;
                                     const plus = document.getElementById("plus");
                                     const minus = document.getElementById("minus");
                                     const buyNow = document.getElementById("buyBtn");

                                        plus.onclick = function () {
                                        quantity++;
                                        localStorage.setItem('qty', quantity)
                                        qty.value = quantity;

                                         };

                                         minus.onclick = function () {
                                         if (quantity > 1) {
                                         quantity--;
                                         localStorage.setItem('qty', quantity)
                                         qty.value = quantity;
                                           }
                                         };


                                  </script>
                              </div>

                          </div>

                          <%
                          }
                          %>


            <div class="serviceSection">

                <div class="serviceBox">
                    <div class="icon"><img src="images/leaves.png" alt="leaves"></div>
                    <h3>Natural & Safe</h3>
                    <p>Homeopathic Medicine</p>
                </div>

                <div class="serviceBox">
                    <div class="icon"><img src="images/click.png" alt="click"></div>
                    <h3>Quality Assured</h3>
                    <p>ISO Certified</p>
                </div>

                <div class="serviceBox">
                    <div class="icon"><img src="images/return.png" alt="return"></div>
                    <h3>Easy Returns</h3>
                    <p>7 Days Return Policy</p>
                </div>

            </div>
  </div>
 </body>
</html>