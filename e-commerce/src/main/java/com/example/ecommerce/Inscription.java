package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "inscription", value = "/inscription")
public class Inscription extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("InscriptionUser.jsp");
        dispatcher.forward(request, response);

    }

    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String name = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String email = request.getParameter("mail");
        String passe = request.getParameter("passe");
        String secret = request.getParameter("secret");


        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Créer la requête SQL SELECT
            String sql = "INSERT INTO CLIENT (NOM,PRENOM,EMAIL,MOT_DE_PASSE,MOT_SECRET) VALUES (?,?,?,?,?)";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, name);
                preparedStatement.setString(2, prenom);
                preparedStatement.setString(3, email);
                preparedStatement.setString(4, passe);
                preparedStatement.setString(5, secret);

                // Utilisez executeUpdate pour une requête d'insertion
                int rowsAffected = preparedStatement.executeUpdate();

                if (rowsAffected > 0) {

                    RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
                    dispatcher.forward(request, response);
                } else {

                    String erreur = "Erreur de saisie";
                    request.setAttribute("erreur", erreur);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("InscriptionUser.jsp");
                    dispatcher.forward(request, response);
                }
            }catch (SQLIntegrityConstraintViolationException e) {
                // Gérer l'exception pour la contrainte d'unicité (e-mail déjà existant)
                String erreur = "L'adresse e-mail existe déjà. Veuillez utiliser une autre adresse e-mail.";
                request.setAttribute("erreur", erreur);
                RequestDispatcher dispatcher = request.getRequestDispatcher("InscriptionUser.jsp");
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
