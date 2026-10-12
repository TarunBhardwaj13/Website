<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <link rel="stylesheet" href="productPage.css">
    <meta charset="UTF-8">
</head>

<body>

<div class="container">

    <!-- Left Sidebar -->
    <div class="leftSide">

        <div class="logo">
            <img src="images/logoProduct.png" width="180" height="120">
        </div>

        <h3>MENU</h3>

        <ul>
            <li><a href="productPage.jsp">📦 Product</a></li>
            <li><a href="orderPage.jsp">🛒 Orders</a></li>
            <li><a href="manageAdmin.jsp">👑 Admin</a></li>

        </ul>

        <div class="home">
        <a href="homePage.jsp">← Back to Home</a>
        </div>
    </div>

    <!-- Right Side -->
    <div class="rightSide">

        <header>

            <h1>Product Management</h1>


                <button type="button" class="add" onclick="openAddModal()">+ Add Product</button>


        </header>

        <div class="content">



            <!-- Add / Update Medicine Form (Lightbox / Modal) -->
            <div id="medicineModal" class="modal" style="display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; background-color:rgba(0,0,0,0.5); justify-content:center; align-items:center;">

                <div class="formBox" style="background:white; padding:20px; border-radius:8px; position:relative; max-width:600px; width:90%;">

                    <span onclick="closeModal()" style="position:absolute; right:15px; top:10px; cursor:pointer; font-weight:bold; font-size:20px;">&times;</span>

                    <h2 id="modalTitle">Add New Medicine</h2>

                    <form id="medicineForm" action="addMedicine" method="post" enctype="multipart/form-data">

                        <input type="hidden" name="action" id="formAction" value="add">
                        <input type="hidden" name="id" id="medicineId">

                        <table>

                            <tr>
                                <td>
                                    Medicine Name<br>
                                    <input type="text" name="medicineName" id="medName" required>
                                </td>

                                <td>
                                    Stock<br>
                                    <input type="number" name="stock" id="medStock" required>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Company Name<br>
                                    <input type="text" name="companyname" id="medCompany" required>
                                </td>

                                <td>
                                    Expiry Date<br>
                                    <input type="date" name="expiryDate" id="medExpiry" required>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Salt<br>
                                    <input type="text" name="salt" id="medSalt">
                                </td>

                                <td>
                                    Medicine Image<br>
                                    <input type="file" name="image" id="medImage">
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Price<br>
                                    <input type="number" step="0.01" name="price" id="medPrice" required>
                                </td>

                                <td>
                                    Description<br>
                                    <textarea name="description" id="medDescription"></textarea>
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    Offer (%)<br>
                                    <input type="number" step="0.01" name="offer" id="medOffer" required>
                                </td>

                                <td>
                                    Category<br>
                                    <select name="category" id="medCategory">
                                        <option value="">Select Category</option>
                                        <option value="HOME">HOME</option>
                                        <option value="MEDICINES">MEDICINES</option>
                                        <option value="HEALTH CARE">HEALTH CARE</option>
                                        <option value="PERSONAL CARE">PERSONAL CARE</option>
                                        <option value="BABY CARE">BABY CARE</option>
                                        <option value="SURGICALS">SURGICALS</option>
                                        <option value="WELLNESS">WELLNESS</option>
                                    </select>
                                </td>
                            </tr>
                        </table>

                        <div class="buttons">

                            <button type="submit" id="submitBtn" class="add">
                                Add Medicine
                            </button>

                        </div>

                    </form>

                </div>

            </div>

            <!-- Medicine List -->

            <div class="tableBox">

                <h1><b> Medicine List</b></h1>

                <table>

                    <tr>

                        <th>Image</th>
                        <th>Medicine</th>
                        <th>Company</th>
                        <th>Salt</th>
                        <th>Price</th>
                        <th>Offer</th>
                        <th>Stock</th>
                        <th>Expiry Date</th>
                        <th>Description</th>
                        <th>Category</th>
                        <th>Action</th>

                    </tr>

                    <%@ page import="DB.HandleDatabase,java.sql.*" %>

                    <%
                        HandleDatabase db = new HandleDatabase();
                        ResultSet rs = db.medicineList();

                        while(rs != null && rs.next()){
                            // Direct Column Names matching your DB Schema
                            String medicineName = rs.getString("medicineName");
                            String companyName = rs.getString("companyName");
                            String salt = rs.getString("salt") != null ? rs.getString("salt") : "";
                            double price = rs.getDouble("price");
                            float offer = rs.getFloat("offer");
                            int stock = rs.getInt("stock");
                            String expiryDate = rs.getString("expiryDate") != null ? rs.getString("expiryDate") : "";
                            String image = rs.getString("image") != null ? rs.getString("image") : "";
                            String description = rs.getString("description") != null ? rs.getString("description") : "";

                            // Safe Category check (Agar DB query me missing ho toh error na de)
                            String category = "";
                            try { category = rs.getString("category") != null ? rs.getString("category") : ""; } catch(Exception e){}

                            // Safe ID check (Unique Key for update/delete)
                            int id = 0;
                            try { id = rs.getInt("id"); } catch(Exception e){}
                    %>

                    <tr>

                        <td>
                            <img src="image/<%= image %>" width="70px" height="70px" onerror="this.src='https://via.placeholder.com/70'">
                        </td>

                        <td><%= medicineName %></td>

                        <td><%= companyName %></td>

                        <td><%= salt %></td>

                        <td>₹<%= price %></td>

                        <td><%= offer %>%</td>

                        <td><%= stock %></td>

                        <td><%= expiryDate %></td>

                        <td><%= description %></td>

                        <td><%= category %></td>

                        <td>

                            <!-- Update & Delete Action Buttons -->
                            <button type="button" class="update"
                                    onclick="openEditModal('<%= id %>', '<%= medicineName %>', '<%= companyName %>', '<%= salt %>', '<%= price %>', '<%= offer %>', '<%= stock %>', '<%= expiryDate %>', '<%= description %>', '<%= category %>')">
                                Update
                            </button>

                            <button type="button" class="delete"
                                    onclick="confirmDelete('<%= id %>', '<%= medicineName %>')">
                                Delete
                            </button>

                        </td>

                    </tr>

                    <%
                        }
                        db.close();
                    %>

                </table>

            </div>

        </div>

    </div>

</div>

<!-- Lightbox JavaScript Control -->
<script>
    const modal = document.getElementById('medicineModal');

    function openAddModal() {
        document.getElementById('modalTitle').innerText = 'Add New Medicine';
        document.getElementById('formAction').value = 'add';
        document.getElementById('submitBtn').innerText = 'Add Medicine';
        document.getElementById('submitBtn').className = 'add';
        document.getElementById('medicineForm').reset();
        modal.style.display = 'flex';
    }

    function openEditModal(id, medicineName, companyName, salt, price, offer, stock, expiryDate, description, category) {
        document.getElementById('modalTitle').innerText = 'Update Medicine';
        document.getElementById('formAction').value = 'update';
        document.getElementById('submitBtn').innerText = 'Update';
        document.getElementById('submitBtn').className = 'update';

        document.getElementById('medicineId').value = id;
        document.getElementById('medName').value = medicineName;
        document.getElementById('medCompany').value = companyName;
        document.getElementById('medSalt').value = salt;
        document.getElementById('medPrice').value = price;
        document.getElementById('medOffer').value = offer;
        document.getElementById('medStock').value = stock;
        document.getElementById('medExpiry').value = expiryDate;
        document.getElementById('medDescription').value = description;
        document.getElementById('medCategory').value = category;

        modal.style.display = 'flex';
    }

    function closeModal() {
        modal.style.display = 'none';
    }

    function confirmDelete(id, name) {
        if (confirm("Kya aap sach me '" + name + "' ko delete karna chahte hain?")) {
            window.location.href = 'addMedicine?action=delete&id=' + id + '&medicineName=' + encodeURIComponent(name);
        }
    }

    window.onclick = function(event) {
        if (event.target === modal) {
            closeModal();
        }
    }
</script>

</body>
</html>