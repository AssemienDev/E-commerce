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

@WebServlet(name = "commandes", value = "/commandes")
public class Commandes extends HttpServlet {
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
                String sqlCommande = "SELECT * FROM COMMANDE, CLIENT WHERE COMMANDE.IDCLIENT = CLIENT.IDCLIENT ORDER BY DATECMD DESC";
                try (PreparedStatement commandesStatement = connection.prepareStatement(sqlCommande)) {
                    ResultSet produitsResultSet = commandesStatement.executeQuery();

                    // Créer une liste pour stocker les résultats de la deuxième requête
                    List<Map<String, String>> listeCommandes = new ArrayList<>();

                    // Traiter les résultats de la requête
                    while (produitsResultSet.next()) {

                        Map<String, String> clientMap = new HashMap<>();

                        String nom = produitsResultSet.getString("nom");
                        String ide = produitsResultSet.getString("idcommande");
                        String prenom = produitsResultSet.getString("prenom");
                        String num = produitsResultSet.getString("numtel");
                        String statuts = produitsResultSet.getString("statutcmd");
                        String date = produitsResultSet.getString("datecmd");

                        // Ajouter les informations du client à la Map
                        clientMap.put("nom", nom);
                        clientMap.put("prenom", prenom);
                        clientMap.put("num", num);
                        clientMap.put("status", statuts);
                        clientMap.put("date",date);
                        clientMap.put("ide", ide);

                        // Ajouter la Map à la liste
                        listeCommandes.add(clientMap);
                    }

                    // Ajouter la liste des clients à la liste des résultats de la première requête
                    request.setAttribute("listeCommandes", listeCommandes);
                }
                request.setAttribute("resultats", nomUtilisateur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Commandes.jsp");
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
}
