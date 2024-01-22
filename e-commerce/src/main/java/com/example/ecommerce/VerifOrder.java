package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "verifOrder", value = "/verif-order")
public class VerifOrder extends HttpServlet {


    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, IOException {
        // Récupérez les paramètres de la requête (productId, userId)

        HttpSession session = request.getSession(false);
        if (session != null) {
            String Id = (String) session.getAttribute("id_user");
            if (Id != null){

            String productId = request.getParameter("productId");
            String userId = request.getParameter("userId");

            // Vérifiez si l'utilisateur a passé une commande pour le produit (logique personnalisée)
            boolean userHasOrdered = checkUserOrder(productId, userId);

            // Renvoyez la réponse au client
            if (userHasOrdered) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("failure");
            }

        }else{
                RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
                dispatcher.forward(request, response);
            }
        }else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
            dispatcher.forward(request, response);
        }
    }

    // Méthode pour vérifier si l'utilisateur a passé une commande pour le produit (exemple)
    private boolean checkUserOrder(String productId, String userId) {
        String sql = "SELECT COUNT(*) AS orderCount " +
                "FROM COMMANDE c " +
                "JOIN LIGNE_COMMANDE lc ON c.IDCOMMANDE = lc.IDCOMMANDE " +
                "WHERE c.IDCLIENT = ? AND lc.REFERENCEPRODUIT = ?";

        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, Integer.parseInt(userId));
            preparedStatement.setInt(2, Integer.parseInt(productId));

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    int orderCount = resultSet.getInt("orderCount");
                    return orderCount > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Gérer l'exception de manière appropriée
        }

        return false; // En cas d'erreur, considérer que l'utilisateur n'a pas passé de commande
    }

}
