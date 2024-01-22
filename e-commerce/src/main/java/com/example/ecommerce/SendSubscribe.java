package com.example.ecommerce;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet(name = "envoyerAbonner", value = "/send-subscriber")
public class SendSubscribe extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String Email = request.getParameter("Email");

        // Insérez le commentaire dans la base de données
        boolean success = insertSubscribe(Email);

        // Renvoyez la réponse au client
        if (success) {
            response.getWriter().write("success");
        } else {
            response.getWriter().write("failure");
        }
    }

    private boolean insertSubscribe(String email) {
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {
            String sql = "INSERT INTO ABONNES (EMAIL, DATE_ABONNEMENT) VALUES ( ?, CURRENT_TIMESTAMP)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setString(1, email);
                int rowsAffected = statement.executeUpdate();
                return rowsAffected > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Gérer les exceptions de manière appropriée dans votre application
            return false;
        }
    }
}
