package com.example.ecommerce;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "saveOrder", value = "/save-order")
public class SaveOrder extends HttpServlet {

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {


        String productId = request.getParameter("productId");
        String userId = request.getParameter("userId");
        String commentaire = request.getParameter("commentaire");


        // Insérez le commentaire dans la base de données
        boolean success = insertComment(productId, userId, commentaire);

        // Renvoyez la réponse au client
        if (success) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }
    }

    private boolean insertComment(String productId, String userId, String commentaire) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO COMMENTAIRES (IDPRODUIT, AUTEUR, COMMENTAIRE, DATECOM) VALUES (?, ?, ?, CURRENT_TIMESTAMP)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, productId);
                statement.setString(2, userId);
                statement.setString(3, commentaire);
                int rowsAffected = statement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Gérer les exceptions de manière appropriée dans votre application
            return false;
        }
    }
}
