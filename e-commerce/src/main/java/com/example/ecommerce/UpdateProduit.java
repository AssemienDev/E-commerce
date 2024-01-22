package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "updateProduit", value = "/update-produit")
public class UpdateProduit extends HttpServlet {
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

                String id = request.getParameter("id");

                // Effectuer une autre requête pour obtenir tous les produits
                String sqlProduits = "SELECT * FROM PRODUITS WHERE REFERENCEPRODUIT = ?";
                try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {

                    produitsStatement.setString(1, id);

                    ResultSet produitsResultSet = produitsStatement.executeQuery();

                    // Créer une liste pour stocker les résultats de la deuxième requête
                    List<Map<String, String>> listeProduits = new ArrayList<>();

                    // Traiter les résultats de la requête
                    while (produitsResultSet.next()) {

                        Map<String, String> clientMap = new HashMap<>();

                        String nom = produitsResultSet.getString("nomproduit");
                        String prix = produitsResultSet.getString("prixunitproduit");
                        String photo = produitsResultSet.getString("photo_produit");
                        String description = produitsResultSet.getString("descproduit");
                        String couleur1 = produitsResultSet.getString("couleur1");
                        String couleur2 = produitsResultSet.getString("couleur2");
                        String couleur3 = produitsResultSet.getString("couleur3");
                        String categorie = produitsResultSet.getString("nomcategorie");


                        // Ajouter les informations du client à la Map
                        clientMap.put("nom", nom);
                        clientMap.put("ide", id);
                        clientMap.put("prix", prix);
                        clientMap.put("photo", photo);
                        clientMap.put("description", description);
                        clientMap.put("couleur1", couleur1);
                        clientMap.put("couleur2", couleur2);
                        clientMap.put("couleur3", couleur3);
                        clientMap.put("categorie", categorie);

                        // Ajouter la Map à la liste
                        listeProduits.add(clientMap);
                    }

                    // Ajouter la liste des clients à la liste des résultats de la première requête
                    request.setAttribute("listeProduits", listeProduits);
                }
                request.setAttribute("resultats",nomUtilisateur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("Update.jsp");
                dispatcher.forward(request, response);

            } catch (SQLException e) {
                // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
                request.setAttribute("erreur", e.getMessage());

                // Redirection vers page2.jsp
                RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
                dispatcher.forward(request, response);
            }
        }else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
            dispatcher.forward(request, response);
        }

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String nomUtilisateur = (String) session.getAttribute("nom_utilisateur");

            String name = request.getParameter("nom");
            String id = request.getParameter("ide");
            String price = request.getParameter("prix");
            String desc = request.getParameter("description");
            String catego = request.getParameter("categorie");
            String color1 = (request.getParameter("couleur1") != null && !request.getParameter("couleur1").isEmpty()) ? request.getParameter("couleur1") : "aucun";
            String color2 = (request.getParameter("couleur2") != null && !request.getParameter("couleur2").isEmpty()) ? request.getParameter("couleur2") : "aucun";
            String color3 = (request.getParameter("couleur3") != null && !request.getParameter("couleur3").isEmpty()) ? request.getParameter("couleur3") : "aucun";

            try {
                // Tentative de conversion de la chaîne en entier
                int priceInt = Integer.parseInt(price);

                // Établir la connexion à la base de données
                try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                    // Créer la requête SQL SELECT
                    String sql = "UPDATE PRODUITS SET NOMPRODUIT=?,DESCPRODUIT=?,PRIXUNITPRODUIT=?,NOMCATEGORIE=?,COULEUR1=?,COULEUR2=?,COULEUR3=? WHERE REFERENCEPRODUIT=?";


                    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                        preparedStatement.setString(1, name);
                        preparedStatement.setString(2, desc);
                        preparedStatement.setInt(3, priceInt);
                        preparedStatement.setString(4, catego);
                        preparedStatement.setString(5, color1);
                        preparedStatement.setString(6, color2);
                        preparedStatement.setString(7, color3);
                        preparedStatement.setString(8, id);

                        // Utilisez executeUpdate pour une requête d'insertion
                        int rowsAffected = preparedStatement.executeUpdate();

                        request.setAttribute("resultats", nomUtilisateur);

                        // Vérifiez si l'insertion a réussi avant de rediriger
                        if (rowsAffected > 0) {
                            String valider = "Enregistrement Validé";
                            request.setAttribute("valide", valider);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateMessage.jsp");
                            dispatcher.forward(request, response);
                        } else {
                            String valider = "Enregistrement Non Validé";
                            request.setAttribute("valide", valider);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateMessage.jsp");
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

            } catch (NumberFormatException e) {
                String valider = "Erreur de saisie dans le prix";
                request.setAttribute("valide", valider);
                request.setAttribute("resultats", nomUtilisateur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("UpdateMessage.jsp");
                dispatcher.forward(request, response);
            }


        }else{
            // Redirection vers page de connexion
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
            dispatcher.forward(request, response);
        }
    }
}
