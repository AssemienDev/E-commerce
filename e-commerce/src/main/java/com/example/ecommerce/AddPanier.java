package com.example.ecommerce;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@WebServlet(name = "AddPanier", value = "/add-panier")
public class AddPanier extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // Récupérer ou créer le panier de l'utilisateur dans la session
        HttpSession session = request.getSession(true);

        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }

        // Récupérer les détails du produit à partir des paramètres de la requête
        String Ide = request.getParameter("ide");
        String productName = request.getParameter("nom");
        String productPhoto = request.getParameter("photo");
        double productPrice = Double.parseDouble(request.getParameter("prix"));
        int productQuantity = Integer.parseInt(request.getParameter("quantity"));
        String productColor = request.getParameter("color");

        // Vérifier si le produit existe déjà dans le panier
        boolean productExists = false;
        for (CartItem item : cart) {
            if (item.getIde().equals(Ide) && item.getColor().equals(productColor)) {
                // Le produit existe déjà, ne rien faire ou mettre à jour la quantité si nécessaire
                productExists = true;
                break;
            }
        }

        if (!productExists) {
            // Le produit n'existe pas encore dans le panier, vous pouvez l'ajouter
            CartItem cartItem = new CartItem(Ide, productName, productPhoto, productPrice, productQuantity, productColor);
            cart.add(cartItem);
        }

        // Rediriger vers une page de confirmation ou de visualisation du panier
        RequestDispatcher dispatcher = request.getRequestDispatcher("Panier.jsp");
        dispatcher.forward(request, response);

    }

}

