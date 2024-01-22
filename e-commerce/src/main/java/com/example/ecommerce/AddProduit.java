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


@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 50)
@WebServlet(name = "admin", value = "/add-produit")
public class AddProduit extends HttpServlet {


    private static final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521/orclpdb";
    private static final String JDBC_USER = "hr";
    private static final String JDBC_PASSWORD = "hr";


    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null) {
            String nomUtilisateur = (String) session.getAttribute("nom_utilisateur");
            request.setAttribute("resultats", nomUtilisateur);
            RequestDispatcher dispatcher = request.getRequestDispatcher("AddProduit.jsp");
            dispatcher.forward(request, response);
        }else{
            // Redirection vers page de connexion
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
            String price = request.getParameter("prix");
            String desc = request.getParameter("description");
            String catego = request.getParameter("categorie");
            Part tof = request.getPart("photo");
            String fileName = tof.getSubmittedFileName();
            String color1 = (request.getParameter("couleur1") != null && !request.getParameter("couleur1").isEmpty()) ? request.getParameter("couleur1") : "aucun";
            String color2 = (request.getParameter("couleur2") != null && !request.getParameter("couleur2").isEmpty()) ? request.getParameter("couleur2") : "aucun";
            String color3 = (request.getParameter("couleur3") != null && !request.getParameter("couleur3").isEmpty()) ? request.getParameter("couleur3") : "aucun";


            // Établir la connexion à la base de données
            try (Connection connection = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASSWORD)) {

                // Créer la requête SQL SELECT
                String sql = "INSERT INTO PRODUITS (NOMPRODUIT,DESCPRODUIT,PRIXUNITPRODUIT,NOMCATEGORIE,PHOTO_PRODUIT,COULEUR1,COULEUR2,COULEUR3) VALUES (?,?,?,?,?,?,?,?)";

                // Spécifier le chemin où le fichier doit être sauvegardé sur le disque
                String savePath = getServletContext().getRealPath("/photoProduit/") + File.separator + fileName;

                // Vérifiez si le répertoire existe, sinon le crée
                File fileSaveDir = new File(savePath);
                if (!fileSaveDir.getParentFile().exists()) {
                    fileSaveDir.getParentFile().mkdirs();
                }

                // Utiliser un flux de sortie pour écrire le contenu de la partie sur le disque
                try (InputStream input = tof.getInputStream();
                     FileOutputStream output = new FileOutputStream(fileSaveDir)) {

                    byte[] buffer = new byte[10240];
                    int length;
                    while ((length = input.read(buffer)) > 0) {
                        output.write(buffer, 0, length);
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                    // Gérer l'exception, si nécessaire
                }


                try (PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
                    preparedStatement.setString(1, name);
                    preparedStatement.setString(2, desc);
                    preparedStatement.setString(3, price);
                    preparedStatement.setString(4, catego);
                    preparedStatement.setString(5, fileName);
                    preparedStatement.setString(6, color1);
                    preparedStatement.setString(7, color2);
                    preparedStatement.setString(8, color3);

                    // Utilisez executeUpdate pour une requête d'insertion
                    int rowsAffected = preparedStatement.executeUpdate();

                    // Vérifiez si l'insertion a réussi avant de rediriger
                    if (rowsAffected > 0) {
                        String valider = "Enregistrement Validée";
                        request.setAttribute("valide", valider);
                        request.setAttribute("resultats", nomUtilisateur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AddProduit.jsp");
                        dispatcher.forward(request, response);
                    } else {
                        request.setAttribute("resultats", nomUtilisateur);
                        RequestDispatcher dispatcher = request.getRequestDispatcher("AddProduit.jsp");
                        dispatcher.forward(request, response);
                    }
                    tof.delete();
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