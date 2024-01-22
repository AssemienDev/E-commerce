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


@WebServlet(name = "detailProduit", value = "/detail-produit")
public class DetailProduit extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            String id = request.getParameter("id");

            // Effectuer une autre requête pour obtenir tous un produit
            String sqlProduits = "SELECT * FROM PRODUITS WHERE REFERENCEPRODUIT=?";
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
                    String ide = produitsResultSet.getString("referenceproduit");


                    // Ajouter les informations du client à la Map
                    clientMap.put("nom", nom);
                    clientMap.put("prix", prix);
                    clientMap.put("photo", photo);
                    clientMap.put("description", description);
                    clientMap.put("couleur1", couleur1);
                    clientMap.put("couleur2", couleur2);
                    clientMap.put("couleur3", couleur3);
                    clientMap.put("ide", ide);

                    // Ajouter la Map à la liste
                    listeProduits.add(clientMap);
                }


                // Effectuer une requête pour obtenir les commentaires liés au produit
                String sqlCommentaires = "SELECT * FROM COMMENTAIRES WHERE IDPRODUIT=?";
                try (PreparedStatement commentairesStatement = connection.prepareStatement(sqlCommentaires)) {
                    commentairesStatement.setString(1, id);

                    ResultSet commentairesResultSet = commentairesStatement.executeQuery();

                    // Créer une liste pour stocker les commentaires
                    List<Map<String, String>> listeCommentaires = new ArrayList<>();

                    // Traiter les résultats des commentaires
                    while (commentairesResultSet.next()) {
                        Map<String, String> commentaireMap = new HashMap<>();

                        String auteur = commentairesResultSet.getString("auteur");
                        String date = commentairesResultSet.getString("datecom");
                        String texte = commentairesResultSet.getString("commentaire");

                        commentaireMap.put("auteur", auteur);
                        commentaireMap.put("date", date);
                        commentaireMap.put("texte", texte);

                        listeCommentaires.add(commentaireMap);
                    }


                    // Ajouter la liste des commentaires à la requête
                    request.setAttribute("listeCommentaires", listeCommentaires);


                    // Effectuer une autre requête pour obtenir tous les produits
                    String sqlAllProduits = "SELECT * FROM PRODUITS ORDER BY DBMS_RANDOM.VALUE() FETCH FIRST 3 ROWS ONLY";
                    try (PreparedStatement produitsAllStatement = connection.prepareStatement(sqlAllProduits)) {

                        ResultSet produitsAllResultSet = produitsAllStatement.executeQuery();

                        // Créer une liste pour stocker les résultats de la deuxième requête
                        List<Map<String, String>> listeAllProduits = new ArrayList<>();

                        // Traiter les résultats de la requête
                        while (produitsAllResultSet.next()) {

                            Map<String, String> clientMap = new HashMap<>();

                            String nom = produitsAllResultSet.getString("nomproduit");
                            String prix = produitsAllResultSet.getString("prixunitproduit");
                            String photo = produitsAllResultSet.getString("photo_produit");
                            String ide = produitsAllResultSet.getString("referenceproduit");


                            // Ajouter les informations du client à la Map
                            clientMap.put("nom", nom);
                            clientMap.put("prix", prix);
                            clientMap.put("photo", photo);
                            clientMap.put("ide", ide);

                            // Ajouter la Map à la liste
                            listeAllProduits.add(clientMap);
                        }
                        // Ajouter la liste des produits à la liste des résultats de la première requête
                        request.setAttribute("listeAllProduits", listeAllProduits);

                }

                    // Ajouter la liste des produits à la liste des résultats de la première requête
                    request.setAttribute("listeProduits", listeProduits);
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("DetailProduitUser.jsp");
            dispatcher.forward(request, response);

        } catch (SQLException e) {
            // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
            request.setAttribute("erreur", e.getMessage());

            // Redirection vers page2.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
            dispatcher.forward(request, response);
        }
    } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }}
