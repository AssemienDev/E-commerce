package com.example.ecommerce;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DeletePanier", value = "/delete-produit-panier")
public class DeleteProduitPanier extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

        // Récupérer l'ID ou l'identifiant unique du produit à supprimer
        String productId = request.getParameter("id");
        String color = request.getParameter("color");

        // Récupérer le panier de l'utilisateur depuis la session
        HttpSession session = request.getSession(false);
        if (session != null) {
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            // Supprimer le produit du panier en fonction de l'ID ou de l'identifiant unique
            if (cart != null && productId != null) {
                cart.removeIf(item -> item.getIde().equals(productId) && item.getColor().equals(color));
            }

            // Mise à jour du panier dans la session
            session.setAttribute("cart", cart);
        }

        // Redirection vers la page du panier après la suppression
        RequestDispatcher dispatcher = request.getRequestDispatcher("Panier.jsp");
        dispatcher.forward(request, response);
    }
}
