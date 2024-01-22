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
import java.util.*;


@WebServlet(name = "accountUser", value = "/account-user")
public class AccountUser extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String Id = (String) session.getAttribute("id_user");

        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Créer la requête SQL SELECT
            String sql = "SELECT * FROM CLIENT WHERE IDCLIENT=? ";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, Id);

                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    String nom = resultSet.getString("nom");
                    String prenom = resultSet.getString("prenom");
                    String mail = resultSet.getString("email");

                    // Effectuer une autre requête pour obtenir tous les produits
                    String sqlCommande = "SELECT * FROM COMMANDE " +
                            "INNER JOIN CLIENT ON COMMANDE.IDCLIENT = CLIENT.IDCLIENT " +
                            "INNER JOIN LIGNE_COMMANDE ON COMMANDE.IDCOMMANDE = LIGNE_COMMANDE.IDCOMMANDE " +
                            "INNER JOIN PRODUITS ON LIGNE_COMMANDE.REFERENCEPRODUIT = PRODUITS.REFERENCEPRODUIT " +
                            "WHERE COMMANDE.IDCLIENT = ?";

                    try (PreparedStatement commandesStatement = connection.prepareStatement(sqlCommande)) {

                        commandesStatement.setString(1, Id);

                        try (ResultSet produitsResultSet = commandesStatement.executeQuery()) {
                            // À l'extérieur de votre boucle while
                            List<Map<String, Object>> listeCommandes = new ArrayList<>();

                            while (produitsResultSet.next()) {
                                String idCommande = produitsResultSet.getString("idcommande");

                                // Recherchez si la commande existe déjà dans la liste
                                Optional<Map<String, Object>> existingCommande = listeCommandes.stream()
                                        .filter(commande -> idCommande.equals(commande.get("idCmd")))
                                        .findFirst();

                                // Si la commande existe déjà, ajoutez simplement le produit à sa liste de produits
                                if (existingCommande.isPresent()) {
                                    Map<String, Object> commande = existingCommande.get();
                                    List<Map<String, String>> produitsList = (List<Map<String, String>>) commande.get("produits");

                                    // Informations du produit
                                    String nomProd = produitsResultSet.getString("nomproduit");
                                    String photo = produitsResultSet.getString("photo_produit");
                                    String prixProd = produitsResultSet.getString("prixunitproduit");
                                    String quantite = produitsResultSet.getString("quantite");

                                    // Ajouter les informations du produit à la liste
                                    Map<String, String> produitMap = new HashMap<>();
                                    produitMap.put("nomproduit", nomProd);
                                    produitMap.put("photo", photo);
                                    produitMap.put("prixunitproduit", prixProd);
                                    produitMap.put("quantite", quantite);

                                    // Ajouter la carte du produit à la liste des produits
                                    produitsList.add(produitMap);

                                } else {
                                    // Si la commande n'existe pas encore, créez une nouvelle carte client
                                    Map<String, Object> clientMap = new HashMap<>();
                                    clientMap.put("idCmd", idCommande);
                                    clientMap.put("status", produitsResultSet.getString("statutcmd"));
                                    clientMap.put("total", produitsResultSet.getString("totalcmd"));

                                    // Créer une nouvelle liste de produits pour cette commande
                                    List<Map<String, String>> produitsList = new ArrayList<>();

                                    // Informations du produit
                                    String nomProd = produitsResultSet.getString("nomproduit");
                                    String photo = produitsResultSet.getString("photo_produit");
                                    String prixProd = produitsResultSet.getString("prixunitproduit");
                                    String quantite = produitsResultSet.getString("quantite");

                                    // Ajouter les informations du produit à la liste
                                    Map<String, String> produitMap = new HashMap<>();
                                    produitMap.put("nomproduit", nomProd);
                                    produitMap.put("photo", photo);
                                    produitMap.put("prixunitproduit", prixProd);
                                    produitMap.put("quantite", quantite);

                                    // Ajouter la carte du produit à la liste des produits
                                    produitsList.add(produitMap);

                                    // Ajouter la liste de produits à la carte du client
                                    clientMap.put("produits", produitsList);

                                    // Ajouter la carte du client à la liste des commandes
                                    listeCommandes.add(clientMap);
                                }
                            }

                            // Utilisez la liste des commandes pour la suite du traitement
                            request.setAttribute("listeCommandes", listeCommandes);

                        }

                        request.setAttribute("nom", nom);
                        request.setAttribute("prenom", prenom);
                        request.setAttribute("mail", mail);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AccountUser.jsp");
                        dispatcher.forward(request, response);
                    }

                }
            }

        } catch (SQLException e) {
            // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
            request.setAttribute("erreur", e.getMessage());

            // Redirection vers page2.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
            dispatcher.forward(request, response);
            }
        }else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
            dispatcher.forward(request, response);
        }
    }

}
