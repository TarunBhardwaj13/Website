import DB.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.sql.Date;

import java.io.IOException;

@WebServlet("/addMedicine")
@MultipartConfig
public class HandleProduct extends HttpServlet {

    // 1. Add aur Update functionality (POST Method)
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HandleDatabase db = new HandleDatabase();
        String action = req.getParameter("action"); // Lightbox form se hidden 'action' read hoga

        try {
            // Aapke exact form input parameter names
            String medicineName = req.getParameter("medicineName");
            String companyName = req.getParameter("companyname");
            String salt = req.getParameter("salt");

            double price = Double.parseDouble(req.getParameter("price"));
            float offer = Float.parseFloat(req.getParameter("offer"));
            int stock = Integer.parseInt(req.getParameter("stock"));

            String expiryDate = req.getParameter("expiryDate");
            Date expDate = null;
            if (expiryDate != null && !expiryDate.trim().isEmpty()) {
                LocalDate localDate = LocalDate.parse(expiryDate);
                expDate = Date.valueOf(localDate);
            }

            String description = req.getParameter("description");

            // Image file handling (Aapka original logic)
            Part part = req.getPart("image");
            String fileName = null;

            if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().isEmpty()) {
                String uploadPath = getServletContext().getRealPath("") + "image";
                File folder = new File(uploadPath);

                if (!folder.exists()) {
                    folder.mkdir();
                }

                fileName = part.getSubmittedFileName();
                File file = new File(folder, fileName);
                Files.copy(part.getInputStream(), file.toPath(), StandardCopyOption.REPLACE_EXISTING);
            }

            // Decision: Add or Update
            if ("update".equalsIgnoreCase(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                db.updateMedicine(id, medicineName, companyName, salt, price, offer, stock, expDate, fileName, description);
            } else {
                // Original Add Medicine
                db.addMedicine(medicineName, companyName, salt, price, offer, stock, expDate, fileName, description);
            }

        } catch (Exception e) {
            System.out.println("Error in HandleProduct POST: " + e.getMessage());
            e.printStackTrace();
        } finally {
            db.close();
        }

        resp.sendRedirect("productPage.jsp");
    }

    // 2. Delete functionality (GET Method)
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HandleDatabase db = new HandleDatabase();
        String action = req.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                db.deleteMedicine(id);
            }
        }

        db.close();
        resp.sendRedirect("productPage.jsp");
    }
}