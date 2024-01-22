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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@WebServlet(name = "abonner", value = "/subscriber")
public class Subscriber extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String nomUtilisateur = (String) session.getAttribute("nom_utilisateur");

            // Établir la connexion à la base de données
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                // Effectuer une autre requête pour obtenir tous les produits
                String sqlProduits = "SELECT * FROM ABONNES ORDER BY ABONNES.DATE_ABONNEMENT DESC";
                try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {
                    ResultSet produitsResultSet = produitsStatement.executeQuery();

                    // Créer une liste pour stocker les résultats de la deuxième requête
                    List<Map<String, String>> listeProduits = new ArrayList<>();

                    // Traiter les résultats de la requête
                    while (produitsResultSet.next()) {

                        Map<String, String> clientMap = new HashMap<>();

                        String email = produitsResultSet.getString("email");

                        // Ajouter les informations du client à la Map
                        clientMap.put("email", email);

                        // Ajouter la Map à la liste
                        listeProduits.add(clientMap);
                    }

                    // Ajouter la liste des produits à la liste des résultats de la première requête
                    request.setAttribute("listeAbonnes", listeProduits);
                }
                request.setAttribute("resultats",nomUtilisateur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Subscriber.jsp");
                dispatcher.forward(request, response);

            } catch (SQLException e) {
                // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
                request.setAttribute("erreur", e.getMessage());

                // Redirection vers page2.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
                dispatcher.forward(request, response);
            }
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
            dispatcher.forward(request, response);
        }
    }
}
