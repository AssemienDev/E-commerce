package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "Deconnexion", value = "/deconnexion")
public class Deconnexion extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Récupérer la session existante
        HttpSession session = request.getSession(false);

        if (session!=null){
            session.removeAttribute("id_user");
            session.removeAttribute("nom");
            session.removeAttribute("prenom");
            session.removeAttribute("email");

            RequestDispatcher dispatcher = request.getRequestDispatcher("ConnexionUser.jsp");
            dispatcher.forward(request, response);
        }

    }
}
