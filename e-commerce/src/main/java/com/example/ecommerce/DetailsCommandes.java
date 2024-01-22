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

@WebServlet(name = "detailsCommandes", value = "/details-commandes")
public class DetailsCommandes extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String nomUtilisateur = (String) session.getAttribute("nom_utilisateur");

            String id = request.getParameter("id");

            // Établir la connexion à la base de données
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                // Effectuer une autre requête pour obtenir tous les produits
                String sqlCommande = "SELECT * FROM COMMANDE " +
                        "INNER JOIN CLIENT ON COMMANDE.IDCLIENT = CLIENT.IDCLIENT " +
                        "INNER JOIN LIGNE_COMMANDE ON COMMANDE.IDCOMMANDE = LIGNE_COMMANDE.IDCOMMANDE " +
                        "INNER JOIN PRODUITS ON LIGNE_COMMANDE.REFERENCEPRODUIT = PRODUITS.REFERENCEPRODUIT " +
                        "WHERE COMMANDE.IDCOMMANDE = ?";


                try (PreparedStatement commandesStatement = connection.prepareStatement(sqlCommande)) {

                    commandesStatement.setString(1, id);

                    try (ResultSet produitsResultSet = commandesStatement.executeQuery()) {
                        // Utilisez une liste pour stocker les informations sur les produits
                        // À l'extérieur de votre boucle while
                        List<Map<String, Object>> listeCommandes = new ArrayList<>();

                        List<Map<String, String>> produitsList = new ArrayList<>();

                        Map<String, Object> clientMap = new HashMap<>();

                        while (produitsResultSet.next()) {
                            // Informations du client (une seule fois)
                            if (clientMap.isEmpty()) {
                                String nom = produitsResultSet.getString("nom");
                                String prenom = produitsResultSet.getString("prenom");
                                String email = produitsResultSet.getString("email");
                                String adresse = produitsResultSet.getString("addlivraison");
                                String num = produitsResultSet.getString("numtel");
                                String date = produitsResultSet.getString("datecmd");
                                String paiement = produitsResultSet.getString("moy_paiement");
                                String statuts = produitsResultSet.getString("statutcmd");
                                String totalCmd = produitsResultSet.getString("totalcmd");

                                // Ajouter les informations du client à la Map (une seule fois)
                                clientMap.put("nom", nom);
                                clientMap.put("prenom", prenom);
                                clientMap.put("email", email);
                                clientMap.put("adresse", adresse);
                                clientMap.put("num", num);
                                clientMap.put("date", date);
                                clientMap.put("paiement", paiement);
                                clientMap.put("status", statuts);
                                clientMap.put("idCommande", id);
                                clientMap.put("total", totalCmd);
                            }

                            // Informations du produit
                            String nomProd = produitsResultSet.getString("nomproduit");
                            String prixProd = produitsResultSet.getString("prixunitproduit");
                            String quantite = produitsResultSet.getString("quantite");

                            // Ajouter les informations du produit à la liste
                            Map<String, String> produitMap = new HashMap<>();
                            produitMap.put("nomproduit", nomProd);
                            produitMap.put("prixunitproduit", prixProd);
                            produitMap.put("quantite", quantite);

                            produitsList.add(produitMap);

                            clientMap.put("produits", produitsList);


                        }

                        listeCommandes.add(clientMap);

                        request.setAttribute("listeCommandes", listeCommandes);

                        request.setAttribute("resultats", nomUtilisateur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("DetailsCommandes.jsp");
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


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String nomUtilisateur = (String) session.getAttribute("nom_utilisateur");

            String id = request.getParameter("idCommande");
            String choix = request.getParameter("choix");

                // Établir la connexion à la base de données
                try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                    // Créer la requête SQL SELECT
                    String sql = "UPDATE COMMANDE SET STATUTCMD=? WHERE IDCOMMANDE=?";


                    try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                        preparedStatement.setString(1, choix);
                        preparedStatement.setString(2, id);

                        // Utilisez executeUpdate pour une requête d'insertion
                        int rowsAffected = preparedStatement.executeUpdate();

                        request.setAttribute("resultats", nomUtilisateur);

                        // Vérifiez si l'insertion a réussi avant de rediriger
                        if (rowsAffected > 0) {
                            String valider = "Statuts modifié avec succès";
                            request.setAttribute("valide", valider);
                            RequestDispatcher dispatcher = request.getRequestDispatcher("ModifDetails.jsp");
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


        }else{
            // Redirection vers page de connexion
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
            dispatcher.forward(request, response);
        }
    }
}
