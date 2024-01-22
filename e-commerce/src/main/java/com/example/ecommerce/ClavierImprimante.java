package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "clavierImprimante", value = "/clavier-imprimante")
public class ClavierImprimante extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Effectuer une autre requête pour obtenir tous les produits
            String sqlProduits = "SELECT * FROM PRODUITS WHERE NOMCATEGORIE IN ('clavier','imprimante')";
            try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {

                ResultSet produitsResultSet = produitsStatement.executeQuery();

                // Créer une liste pour stocker les résultats de la deuxième requête
                List<Map<String, String>> listeProduits = new ArrayList<>();

                // Traiter les résultats de la requête
                while (produitsResultSet.next()) {

                    Map<String, String> clientMap = new HashMap<>();

                    String nom = produitsResultSet.getString("nomproduit");
                    String prix = produitsResultSet.getString("prixunitproduit");
                    String photo = produitsResultSet.getString("photo_produit");
                    String ide = produitsResultSet.getString("referenceproduit");


                    // Ajouter les informations du client à la Map
                    clientMap.put("nom", nom);
                    clientMap.put("prix", prix);
                    clientMap.put("photo", photo);
                    clientMap.put("ide", ide);

                    // Ajouter la Map à la liste
                    listeProduits.add(clientMap);
                }

                // Ajouter la liste des produits à la liste des résultats de la première requête
                request.setAttribute("listeProduits", listeProduits);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("Clavier&Imprimante.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
            request.setAttribute("erreur", e.getMessage());

            // Redirection vers page2.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
            dispatcher.forward(request, response);
        }
    }
}
