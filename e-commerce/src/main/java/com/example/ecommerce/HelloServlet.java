package com.example.ecommerce;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "helloServlet", value = "/hello-servlet")
public class HelloServlet extends HttpServlet {

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
                String sqlProduits = "SELECT * FROM CLIENT";
                try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {
                    ResultSet produitsResultSet = produitsStatement.executeQuery();

                    // Créer une liste pour stocker les résultats de la deuxième requête
                    List<Map<String, String>> listeClients = new ArrayList<>();

                    // Traiter les résultats de la requête
                    while (produitsResultSet.next()) {

                        Map<String, String> clientMap = new HashMap<>();

                        String nom = produitsResultSet.getString("nom");
                        String prenom = produitsResultSet.getString("prenom");
                        String email = produitsResultSet.getString("email");
                        String mot_secret = produitsResultSet.getString("mot_secret");

                        // Ajouter les informations du client à la Map
                        clientMap.put("nom", nom);
                        clientMap.put("prenom", prenom);
                        clientMap.put("email", email);
                        clientMap.put("mot_secret", mot_secret);

                        // Ajouter la Map à la liste
                        listeClients.add(clientMap);
                    }

                    // Ajouter la liste des clients à la liste des résultats de la première requête
                    request.setAttribute("listeClients", listeClients);
                }
                request.setAttribute("resultats", nomUtilisateur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("AcceuilAdmin.jsp");
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


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String login = request.getParameter("mail");
        String passe = request.getParameter("passe");


        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Créer la requête SQL SELECT
            String sql = "SELECT NOM FROM ADMINISTRATEUR WHERE MAIL=? AND MDP=?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, login);
                preparedStatement.setString(2, passe);

                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    String resultats = resultSet.getString("nom");


                    // Récupérer la session existante ou en créer une nouvelle
                    HttpSession session = request.getSession(true);

                    // Définir un attribut de session
                    session.setAttribute("nom_utilisateur", resultats);

                    // Effectuer une autre requête pour obtenir tous les produits
                    String sqlProduits = "SELECT * FROM CLIENT";
                    try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {
                        ResultSet produitsResultSet = produitsStatement.executeQuery();

                        // Créer une liste pour stocker les résultats de la deuxième requête
                        List<Map<String, String>> listeClients = new ArrayList<>();

                        // Traiter les résultats de la requête
                        while (produitsResultSet.next()) {

                            Map<String, String> clientMap = new HashMap<>();

                            String nom = produitsResultSet.getString("nom");
                            String prenom = produitsResultSet.getString("prenom");
                            String email = produitsResultSet.getString("email");
                            String mot_secret = produitsResultSet.getString("mot_secret");

                            // Ajouter les informations du client à la Map
                            clientMap.put("nom", nom);
                            clientMap.put("prenom", prenom);
                            clientMap.put("email", email);
                            clientMap.put("mot_secret", mot_secret);

                            // Ajouter la Map à la liste
                            listeClients.add(clientMap);
                        }

                        // Ajouter la liste des clients à la liste des résultats de la première requête
                        request.setAttribute("listeClients", listeClients);
                    }

                    request.setAttribute("resultats", resultats);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("AcceuilAdmin.jsp");
                    dispatcher.forward(request, response);
                } else {
                    String erreur = "Mail ou mot de passe incorrect";

                    request.setAttribute("erreur", erreur);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
                    dispatcher.forward(request, response);
                }
            }

        } catch (SQLException e) {
            // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
            request.setAttribute("erreur", e.getMessage());

            // Redirection vers page2.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
            dispatcher.forward(request, response);
        }
    }
}

