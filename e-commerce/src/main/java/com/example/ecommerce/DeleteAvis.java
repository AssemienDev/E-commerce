package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;


@WebServlet(name = "deleteAvis", value = "/delete-avis")
public class DeleteAvis extends HttpServlet {
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
                String sqlProduits = "DELETE FROM COMMENTAIRES WHERE IDCOMMENTAIRE = ?";
                try (PreparedStatement produitsStatement = connection.prepareStatement(sqlProduits)) {

                    produitsStatement.setString(1, id);

                    // Utiliser executeUpdate au lieu de executeQuery
                    int rowsAffected = produitsStatement.executeUpdate();

                    // Vérifier le nombre de lignes affectées
                    if (rowsAffected > 0) {
                        String resultat = "Commentaire Supprimer";
                        request.setAttribute("reponse", resultat);
                        request.setAttribute("resultats",nomUtilisateur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteAvis.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        String resultat = "Commentaire Non Supprimer";
                        request.setAttribute("Reponse", resultat);
                        request.setAttribute("resultats",nomUtilisateur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("DeleteAvis.jsp");
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
        }else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("AdminConnexion.jsp");
            dispatcher.forward(request, response);
        }

    }
}
