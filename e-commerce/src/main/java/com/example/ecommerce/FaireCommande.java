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
import java.util.List;



@WebServlet(name = "faireCommande", value = "/faire-commande")
public class FaireCommande extends HttpServlet {

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String id = (String) session.getAttribute("id_user");
            if (id != null){
                double total = (Double) session.getAttribute("total");
                request.setAttribute("IdUser",id);
                request.setAttribute("Total",total);
                RequestDispatcher dispatcher = request.getRequestDispatcher("PageDeCommande.jsp");
                dispatcher.forward(request, response);
            }else{
                RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
                dispatcher.forward(request, response);
            }
        }else{
            RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
            dispatcher.forward(request, response);
        }
    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            String id = (String) session.getAttribute("id_user");
            if (id != null){

                String idUtilisateur = request.getParameter("idUSer");
                String ville = request.getParameter("ville");
                String quartier = request.getParameter("quartier");
                String numTel = request.getParameter("num");
                String adresseLivraison = ville+","+quartier;
                double totalCommandeValue = Double.parseDouble(request.getParameter("totalPrix"));
                String moyenPaiement = request.getParameter("moypaiement");

                Connection connection = null;
                try {
                    connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD);
                    connection.setAutoCommit(false);
                    List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
                    if (cart != null && !cart.isEmpty()) {
                    // Étape 1 : Insérer la commande dans la table COMMANDE
                    // Utiliser PreparedStatement pour éviter les attaques par injection SQL
                    String insertCommandeQuery = "INSERT INTO COMMANDE (IDCLIENT, ADDLIVRAISON, NUMTEL, DATECMD, STATUTCMD, TOTALCMD, MOY_PAIEMENT) VALUES (?, ?, ?, CURRENT_TIMESTAMP, 'en cours', ?, ?)";
                    try (PreparedStatement commandeStatement = connection.prepareStatement(insertCommandeQuery, new String[]{"IDCOMMANDE"})) {
                        // Remplacer les valeurs ci-dessous avec celles appropriées
                        commandeStatement.setInt(1, Integer.parseInt(idUtilisateur));
                        commandeStatement.setString(2, adresseLivraison);
                        commandeStatement.setString(3, numTel);
                        commandeStatement.setString(4, String.valueOf(totalCommandeValue));
                        commandeStatement.setString(5, moyenPaiement);
                        int rowsAffected = commandeStatement.executeUpdate();

                        if (rowsAffected > 0) {
                        try (ResultSet generatedKeys = commandeStatement.getGeneratedKeys()) {
                            if (generatedKeys.next()) {

                                // Récupérer l'ID de la commande générée
                                int idCommande = generatedKeys.getInt(1);

                                // Étape 2 : Insérer les lignes de commande dans la table LIGNE_COMMANDE
                                // Utiliser PreparedStatement pour éviter les attaques par injection SQL
                                String insertLigneCommandeQuery = "INSERT INTO LIGNE_COMMANDE (IDCOMMANDE, REFERENCEPRODUIT, QUANTITE, COULEUR) VALUES (?, ?, ?, ?)";
                                try (PreparedStatement ligneCommandeStatement = connection.prepareStatement(insertLigneCommandeQuery)) {
                                    for (CartItem cartItem : cart) {
                                        ligneCommandeStatement.setInt(1, idCommande);
                                        ligneCommandeStatement.setInt(2, Integer.parseInt(cartItem.getIde()));
                                        ligneCommandeStatement.setInt(3, cartItem.getQuantity());
                                        ligneCommandeStatement.setString(4, cartItem.getColor());
                                        ligneCommandeStatement.executeUpdate();
                                    }
                                }


                                connection.commit();
                                String resultats = "Votre commande est valider";
                                request.setAttribute("resultats", resultats);
                                // Maintenant, vous pouvez utiliser l'idCommande comme nécessaire
                                RequestDispatcher dispatcher = request.getRequestDispatcher("PageDeCommandeValider.jsp");
                                dispatcher.forward(request, response);

                            }

                        }
                    }

                    }
                    } else {
                        String resultats = "Votre commande n'est pas valider";
                        request.setAttribute("resultats", resultats);
                        // Maintenant, vous pouvez utiliser l'idCommande comme nécessaire
                        RequestDispatcher dispatcher = request.getRequestDispatcher("PageDeCommandeValider.jsp");
                        dispatcher.forward(request, response);
                    }
                } catch (SQLException e) {
                    e.printStackTrace();  // Gérer l'exception principale
                    // Passer l'erreur comme attribut de requête pour l'afficher dans la page JSP
                    request.setAttribute("erreur", e.getMessage());
                    // Redirection vers page2.jsp
                    RequestDispatcher dispatcher = request.getRequestDispatcher("page2.jsp");
                    dispatcher.forward(request, response);
                } finally {
                    // Assurez-vous de fermer la connexion dans le bloc finally
                    if (connection != null) {
                        try {
                            connection.close();
                        } catch (SQLException closeException) {
                            closeException.printStackTrace();  // Gérer l'exception de fermeture de connexion si nécessaire
                        }
                    }
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


}
