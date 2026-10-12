package DB;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandleDatabase implements DBAttributes {
    private Connection connection;
    private Statement statement;

    public HandleDatabase() {
        try {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                System.out.println("Driver error: " + e);
            }

            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            statement = connection.createStatement();

            statement.executeUpdate("CREATE DATABASE IF NOT EXISTS " + DB_NAME);

            statement.close();
            connection.close();

            connection = DriverManager.getConnection(URL + DB_NAME, USERNAME, PASSWORD);
            statement = connection.createStatement();

            System.out.println("Connected to database: " + DB_NAME);

            // Initialize Tables
            createUserTbl();
            createMedicineTbl();
            createCustomerTable();
            createAdminTable();

            // --- NAYE TABLES ADD KIYE HAIN ---
            createOrdersTable();
            createOrderItemsTable();

        } catch (SQLException ex) {
            System.out.println("Error connecting to DB: " + ex.getMessage());
        }
    }

    public Connection getConnection() {
        return this.connection;
    }

    // ==========================================
    // 1. NAYE TABLES CREATE KARNE KE METHODS
    // ==========================================

    private void createOrdersTable() {
        try {
            Statement st = connection.createStatement();
            String query = "CREATE TABLE IF NOT EXISTS orders (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL, " +
                    "total_amount DOUBLE NOT NULL, " +
                    "status VARCHAR(50) DEFAULT 'Completed', " +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, " +
                    "FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE)";
            st.executeUpdate(query);
            st.close();
            System.out.println("Orders Table Ready");
        } catch (Exception e) {
            System.out.println("Error creating orders table: " + e);
        }
    }

    private void createOrderItemsTable() {
        try {
            Statement st = connection.createStatement();
            String query = "CREATE TABLE IF NOT EXISTS order_items (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "order_id INT NOT NULL, " +
                    "medicine_id INT NOT NULL, " +
                    "quantity INT NOT NULL, " +
                    "price DOUBLE NOT NULL, " +
                    "FOREIGN KEY(order_id) REFERENCES orders(id) ON DELETE CASCADE, " +
                    "FOREIGN KEY(medicine_id) REFERENCES medicine(id) ON DELETE CASCADE)";
            st.executeUpdate(query);
            st.close();
            System.out.println("Order Items Table Ready");
        } catch (Exception e) {
            System.out.println("Error creating order_items table: " + e);
        }
    }

    // ==========================================
    // 2. ORDER INSERT KARNE KA METHOD
    // ==========================================

    // Jab user checkout karega tab is method ko call karein
    public int createOrder(int userId, double totalAmount) {
        int orderId = -1;
        try {
            String sql = "INSERT INTO orders(user_id, total_amount) VALUES(?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setDouble(2, totalAmount);
            int affected = ps.executeUpdate();

            if (affected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("Error creating order: " + e.getMessage());
        }
        return orderId;
    }

    // Ek order ke andar item/medicine add karne ke liye
    public boolean addOrderItem(int orderId, int medicineId, int quantity, double price) {
        try {
            String sql = "INSERT INTO order_items(order_id, medicine_id, quantity, price) VALUES(?, ?, ?, ?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, orderId);
            ps.setInt(2, medicineId);
            ps.setInt(3, quantity);
            ps.setDouble(4, price);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error adding order item: " + e.getMessage());
        }
        return false;
    }

    // ==========================================
    // 3. PURANE SAARE ORDERS FETCH KARNE KA METHOD
    // ==========================================

    public ResultSet getUserOrderHistory(int userId) {
        try {
            String query = "SELECT " +
                    "o.id AS order_id, o.total_amount, o.status, o.created_at, " +
                    "oi.quantity, oi.price AS item_price, " +
                    "m.medicineName, m.image " +
                    "FROM orders o " +
                    "JOIN order_items oi ON o.id = oi.order_id " +
                    "JOIN medicine m ON oi.medicine_id = m.id " +
                    "WHERE o.user_id = ? " +
                    "ORDER BY o.created_at DESC"; // Sabse purane orders bhi aayenge, latest top par!

            PreparedStatement ps = connection.prepareStatement(query);
            ps.setInt(1, userId);
            return ps.executeQuery();
        } catch (Exception e) {
            System.out.println("Error fetching user order history: " + e.getMessage());
        }
        return null;
    }

    // --- AAPKA PEHLE SE MAUJOOD CODE BELOW ---

    private void createUserTbl() {
        try {
            Statement st = connection.createStatement();
            String tableQuery = "CREATE TABLE IF NOT EXISTS user (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "name VARCHAR(20) NOT NULL, " +
                    "Username VARCHAR(50) UNIQUE NOT NULL, " +
                    "Password VARCHAR(20), " +
                    "email VARCHAR(100) UNIQUE)";
            st.executeUpdate(tableQuery);
            st.close();
            System.out.println("Database and Table Ready");
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public boolean insertData(String name, String Username, String Password, String email) {
        try {
            PreparedStatement pstmt = connection.prepareStatement("INSERT INTO user (Name, Username, Password, email) VALUES (?, ?, ?, ?)");
            pstmt.setString(1, name);
            pstmt.setString(2, Username);
            pstmt.setString(3, Password);
            pstmt.setString(4, email);
            pstmt.executeUpdate();
            return true;
        } catch (Exception e) {
            System.out.println(e);
            return false;
        }
    }

    public boolean updateAdmin(int userId, boolean isAdmin) {
        try {
            if (isAdmin) {
                PreparedStatement check = connection.prepareStatement("SELECT * FROM admin WHERE user_id=?");
                check.setInt(1, userId);
                ResultSet rs = check.executeQuery();
                if (!rs.next()) {
                    PreparedStatement ps = connection.prepareStatement("INSERT INTO admin(user_id) VALUES(?)");
                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }
            } else {
                PreparedStatement ps = connection.prepareStatement("DELETE FROM admin WHERE user_id=?");
                ps.setInt(1, userId);
                ps.executeUpdate();
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public ResultSet searchUser(String search) {
        try {
            String query = "SELECT * FROM user WHERE username LIKE ? OR email LIKE ?";
            PreparedStatement ps = connection.prepareStatement(query);
            ps.setString(1, "%" + search + "%");
            ps.setString(2, "%" + search + "%");
            return ps.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void createAdminTable() {
        try {
            Statement st = connection.createStatement();
            String query = "CREATE TABLE IF NOT EXISTS admin (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT NOT NULL UNIQUE, " +
                    "FOREIGN KEY(user_id) REFERENCES user(id) ON DELETE CASCADE)";
            st.executeUpdate(query);
            st.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public ResultSet adminList() {
        try {
            Statement st = connection.createStatement();
            String query = "SELECT admin.id AS adminId, user.id, user.name, user.username, user.email FROM admin INNER JOIN user ON admin.user_id = user.id";
            return st.executeQuery(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String validateUser(String username, String password) {
        String name = "none";
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT name FROM user WHERE (username = ? OR email = ?) AND password = ?");
            ps.setString(1, username);
            ps.setString(2, username);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                name = rs.getString(1);
            }
            return name;
        } catch (Exception e) {
            System.out.println("Error to validate user " + e);
        }
        return name;
    }

    public boolean updatePassword(String usernameOrEmail, String newPassword) {
        try {
            PreparedStatement ps = connection.prepareStatement("UPDATE user SET password=? WHERE username=? OR email=?");
            ps.setString(1, newPassword);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, usernameOrEmail);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println(e);
        }
        return false;
    }

    public int getUserId(String usernameOrEmail) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT id FROM user WHERE username=? OR email=?");
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public boolean isAdmin(int userId) {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM admin WHERE user_id=?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void createMedicineTbl() {
        try {
            Statement st = connection.createStatement();
            String sql = "CREATE TABLE IF NOT EXISTS medicine (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "medicineName VARCHAR(100) NOT NULL, " +
                    "companyName VARCHAR(100) NOT NULL, " +
                    "salt VARCHAR(200), " +
                    "price FLOAT, " +
                    "offer FLOAT, " +
                    "stock INT, " +
                    "expiryDate DATE, " +
                    "image VARCHAR(255), " +
                    "description TEXT, " +
                    "category VARCHAR(20))";
            st.executeUpdate(sql);
            st.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public boolean addMedicine(String medicineName, String companyName, String salt, double price, float offer, int stock, Date expiryDate, String image, String description) {
        try {
            PreparedStatement ps = connection.prepareStatement("INSERT INTO medicine(medicineName,companyName,salt,price,offer,stock,expiryDate,image,description) VALUES(?,?,?,?,?,?,?,?,?)");
            ps.setString(1, medicineName);
            ps.setString(2, companyName);
            ps.setString(3, salt);
            ps.setDouble(4, price);
            ps.setFloat(5, offer);
            ps.setInt(6, stock);
            ps.setDate(7, expiryDate);
            ps.setString(8, image);
            ps.setString(9, description);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error : " + e.getMessage());
        }
        return false;
    }

    public ResultSet medicineList() {
        try {
            PreparedStatement pst = connection.prepareStatement("SELECT * FROM medicine");
            return pst.executeQuery();
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return null;
    }

    public ResultSet categoryWiseMedicineList(String category) {
        try {
            PreparedStatement pst = connection.prepareStatement("SELECT * FROM medicine WHERE category = ?");
            pst.setString(1, category);
            return pst.executeQuery();
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return null;
    }

    public ResultSet usesWiseMedicineList(String type, String name) {
        try {
            PreparedStatement pst = connection.prepareStatement("SELECT * FROM medicine WHERE " + type + " = ?");
            pst.setString(1, name);
            return pst.executeQuery();
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return null;
    }

    public boolean updateMedicine(int id, String medicineName, String companyName, String salt, double price, float offer, int stock, Date expiryDate, String image, String description) {
        try {
            PreparedStatement ps;
            if (image != null && !image.trim().isEmpty()) {
                String sql = "UPDATE medicine SET medicineName=?, companyName=?, salt=?, price=?, offer=?, stock=?, expiryDate=?, image=?, description=? WHERE id=?";
                ps = connection.prepareStatement(sql);
                ps.setString(1, medicineName);
                ps.setString(2, companyName);
                ps.setString(3, salt);
                ps.setDouble(4, price);
                ps.setFloat(5, offer);
                ps.setInt(6, stock);
                ps.setDate(7, expiryDate);
                ps.setString(8, image);
                ps.setString(9, description);
                ps.setInt(10, id);
            } else {
                String sql = "UPDATE medicine SET medicineName=?, companyName=?, salt=?, price=?, offer=?, stock=?, expiryDate=?, description=? WHERE id=?";
                ps = connection.prepareStatement(sql);
                ps.setString(1, medicineName);
                ps.setString(2, companyName);
                ps.setString(3, salt);
                ps.setDouble(4, price);
                ps.setFloat(5, offer);
                ps.setInt(6, stock);
                ps.setDate(7, expiryDate);
                ps.setString(8, description);
                ps.setInt(9, id);
            }
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error updating: " + e.getMessage());
        }
        return false;
    }

    public boolean deleteMedicine(int id) {
        try {
            PreparedStatement ps = connection.prepareStatement("DELETE FROM medicine WHERE id=?");
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error deleting: " + e.getMessage());
        }
        return false;
    }

    public ResultSet productWiseMedicineList(String medicineName) {
        try {
            PreparedStatement pst = connection.prepareStatement("SELECT * FROM medicine WHERE medicineName = ?");
            pst.setString(1, medicineName);
            return pst.executeQuery();
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return null;
    }

    public ResultSet order() {
        try {
            PreparedStatement ps = connection.prepareStatement("SELECT * FROM customer ORDER BY id DESC");
            return ps.executeQuery();
        } catch (Exception e) {
            System.out.println("Error : " + e);
        }
        return null;
    }

    private void createCustomerTable() {
        try {
            Statement st = connection.createStatement();
            String sql = "CREATE TABLE IF NOT EXISTS customer (" +
                    "id INT AUTO_INCREMENT PRIMARY KEY, " +
                    "user_id INT, " +                       // <--- Naya Column (User Mapping)
                    "fullName VARCHAR(100), " +
                    "mobileNumber VARCHAR(15), " +
                    "pincode VARCHAR(10), " +
                    "locality VARCHAR(100), " +
                    "address VARCHAR(255), " +
                    "landmark VARCHAR(100), " +
                    "city VARCHAR(100), " +
                    "state VARCHAR(100), " +
                    "addressType VARCHAR(20), " +
                    "payment_amount VARCHAR(50), " +
                    "payment_status VARCHAR(50), " +
                    "transaction_id VARCHAR(100) DEFAULT '-', " +
                    "products_detail TEXT, " +              // <--- Naya Column (Multiple Products String)
                    "order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP)";

            st.executeUpdate(sql);
            st.close();
            System.out.println("Customer Table Created Successfully");
        } catch (Exception e) {
            System.out.println("Error in createCustomerTable: " + e);
        }
    }

    public int addCustomer(int userId, String fullName, String mobileNumber, String pincode, String locality,
                           String address, String landmark, String city, String state,
                           String addressType, String paymentAmount, String paymentStatus,
                           String transactionId, String productsDetail) {

        int generatedId = -1;
        try {
            String sql = "INSERT INTO customer(user_id, fullName, mobileNumber, pincode, locality, address, landmark, city, state, addressType, payment_amount, payment_status, transaction_id, products_detail) " +
                    "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            ps.setInt(1, userId);
            ps.setString(2, fullName != null ? fullName : "");
            ps.setString(3, mobileNumber != null ? mobileNumber : "");
            ps.setString(4, pincode != null ? pincode : "");
            ps.setString(5, locality != null ? locality : "");
            ps.setString(6, address != null ? address : "");
            ps.setString(7, landmark != null ? landmark : "");
            ps.setString(8, city != null ? city : "");
            ps.setString(9, state != null ? state : "");
            ps.setString(10, addressType != null ? addressType : "");
            ps.setString(11, paymentAmount != null ? paymentAmount : "0.00");
            ps.setString(12, paymentStatus != null ? paymentStatus : "Cash On Delivery");
            ps.setString(13, transactionId != null ? transactionId : "-");
            ps.setString(14, productsDetail != null ? productsDetail : "");

            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        } catch (Exception e) {
            System.out.println("Database Exception in addCustomer: " + e.getMessage());
        }

        return generatedId;
    }

//    (History Fetch Method):

    public ResultSet getUserOrdersFromCustomerTable(int userId) {
        try {
            String sql = "SELECT * FROM customer WHERE user_id = ? ORDER BY id DESC";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeQuery();
        } catch (Exception e) {
            System.out.println("Error fetching orders: " + e.getMessage());
        }
        return null;
    }

    public void close() {
        try {
            if (statement != null && !statement.isClosed()) statement.close();
            if (connection != null && !connection.isClosed()) connection.close();
        } catch (SQLException e) {
            System.out.println("Error closing resources: " + e.getMessage());
        }
    }
}