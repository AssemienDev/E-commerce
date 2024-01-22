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

@WebServlet(name = "connexion", value = "/connexion")
public class Connexion extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
        dispatcher.forward(request, response);

    }

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String email = request.getParameter("mail");
        String passe = request.getParameter("passe");


        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Créer la requête SQL SELECT
            String sql = "SELECT * FROM CLIENT WHERE EMAIL=? AND MOT_DE_PASSE=?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, email);
                preparedStatement.setString(2, passe);

                // Utilisez executeUpdate pour une requête d'insertion
                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {
                    String resultats = resultSet.getString("idclient");
                    String resultat1 = resultSet.getString("nom");
                    String resultat2 = resultSet.getString("prenom");
                    String resultat3 = resultSet.getString("email");

                    // Récupérer la session existante ou en créer une nouvelle
                    HttpSession session = request.getSession(true);

                    // Définir un attribut de session
                    session.setAttribute("id_user", resultats);
                    session.setAttribute("nom", resultat1);
                    session.setAttribute("prenom", resultat2);
                    session.setAttribute("email", resultat3);

                    RequestDispatcher dispatcher = request.getRequestDispatcher("index.jsp");
                    dispatcher.forward(request, response);

                } else {

                    String erreur = "Mail ou mot de passe incorrect";
                    request.setAttribute("erreur", erreur);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
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
