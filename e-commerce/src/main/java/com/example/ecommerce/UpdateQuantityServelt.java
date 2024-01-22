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

@WebServlet(name = "UpdateQuantityServlet", value = "/update-quantity")
public class UpdateQuantityServelt extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // Récupérer l'ID du produit et le changement de quantité depuis la requête
        String productId = request.getParameter("productId");
        int change = Integer.parseInt(request.getParameter("change"));
        String couleur = request.getParameter("color");

        // Récupérer le panier de l'utilisateur depuis la session
        HttpSession session = request.getSession(false);
        if (session != null) {
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

            // Mettre à jour la quantité du produit dans le panier
            if (cart != null && productId != null) {
                for (CartItem item : cart) {
                    if (item.getIde().equals(productId) && item.getColor().equals(couleur)) {
                            item.setQuantity(change);
                    }
                }
            }

            // Mettre à jour le panier dans la session
            session.setAttribute("cart", cart);
        }


        // Répondre à la requête AJAX
        response.getWriter().write("Success");


    }
}
