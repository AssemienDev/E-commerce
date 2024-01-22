package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.*;


@WebServlet(name = "MotPasseOublier", value = "/passe-oublier")
public class MotPasseOublie extends HttpServlet {
    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        RequestDispatcher dispatcher = request.getRequestDispatcher("PasseOublieUser.jsp");
        dispatcher.forward(request, response);

    }


    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String login = request.getParameter("mail");
        String passe = request.getParameter("secret");


        // Établir la connexion à la base de données
        try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

            // Créer la requête SQL SELECT
            String sql = "SELECT * FROM CLIENT WHERE EMAIL=? AND MOT_SECRET=?";

            try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                preparedStatement.setString(1, login);
                preparedStatement.setString(2, passe);

                ResultSet resultSet = preparedStatement.executeQuery();

                if (resultSet.next()) {

                    String resultat1 = resultSet.getString("mot_de_passe");

                    request.setAttribute("resultat2", login);
                    request.setAttribute("resultat1", resultat1);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("PasseOublieUserCode.jsp");
                    dispatcher.forward(request, response);


                } else {
                    String erreur = "Mail ou code secret incorrect";

                    request.setAttribute("erreur", erreur);
                    RequestDispatcher dispatcher = request.getRequestDispatcher("PasseOublieUser.jsp");
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
