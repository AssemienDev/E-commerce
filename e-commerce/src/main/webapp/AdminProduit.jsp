<%@ page import="java.util.Map" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Produits</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        *{
            box-sizing: border-box;
            margin-top: 0%;
            margin-right: 0%;
        }
        .actif{
            background-color: #EE4900;
            height: 40px;
        }
        .barre{
            width: 97%;
            height: 40px;
            margin-left: 2%;
            margin-top: 0%;
        }
        a{
            text-decoration: none;
            text-align: center;
        }
         .barre a{
             font-size: x-large;
             color: #EE4900;
         }
        .barre .element{
            border-left: 1px solid;
            border-left-color: #001620;

        }
        ul{
            list-style: none;
        }
    </style>
</head>
<body style="background-color: #001620;">
<header>
    <nav style="margin-top: -4%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" width="150" style="margin-left: 15%;">
            <div class="container" style="margin-top: -9.1%; margin-left: 10%;">
                <div class="row">
                    <div class="col-sm" style="margin-left: 55%; margin-top: -0.5%;">
                        <%
                            String resultats = (String) request.getAttribute("resultats");
                            if (resultats != null) {
                        %>
                        <p class="fw-bold mx-2 my-1" style="color: white; font-size: x-large;"><%= resultats %></p>
                        <%
                            }
                        %>
                        <button class="btn" style="background-color: #EE4900; margin-left: 40%; margin-top: -15%;"><a href="administrateur" style="color: white;">DÉCONNEXION</a></button>
                    </div>
                </div>
            </div>
        </div>
        <div class="barre bg-light my-2">
            <div class="row">
                <div class="col-3 element text-center">
                    <a href="hello-servlet" style="color: #EE4900">UTILISATEUR</a>
                </div>
                <div class="col-2 actif element text-center">
                    <a href="produit-admin" style="color:white;">PRODUITS</a>
                </div>
                <div class="col-2 element text-center">
                    <a href="commandes">COMMANDES</a>
                </div>
                <div class="col-3 element text-center">
                    <a href="avis" style="color: #EE4900">COMMENTAIRES</a>
                </div>
                <div class="col-2 element text-center">
                    <a href="subscriber" style="color: #EE4900">SUBSCRIBER</a>
                </div>
            </div>
        </div>
    </nav>
</header>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<div class="principale">
    <div class="container">
        <div class="row">
            <% List<Map<String, String>> listeProduits = (List<Map<String, String>>) request.getAttribute("listeProduits");
                if (listeProduits != null && !listeProduits.isEmpty()) {
                for (Map<String, String> produit : listeProduits) { %>
            <div class="col-12" style="color: white; margin-top: 8%; border: 1px solid white; border-radius: 2%; padding: 2%;">
                <div class="row">
                    <div class="col-6">
                        <img width="250" height="203" alt="produit" src="photoProduit/<%=produit.get("photo") %>" >
                        <p class="text-center"><%= produit.get("nom") %></p>
                        <p class="text-center"><%= produit.get("prix") %></p>
                    </div>
                    <div class="col-6">
                        <p><%= produit.get("description") %></p>
                        <p>couleur: <%= produit.get("couleur1") %>, <%= produit.get("couleur2") %>, <%= produit.get("couleur3") %></p>
                        <p>Catégorie: <%= produit.get("categorie") %></p>
                        <div style="margin-top: 8%; margin-left: 30%;">
                            <a class="btn w-25" style="background-color: #EE4900; color: white;" href="update-produit?id=<%= produit.get("ide") %>">UPDATE</a>
                            <a class="btn w-25" style="background-color: red; color: white; margin-left: 10%;" href="delete-produit?id=<%= produit.get("ide") %>">DELETE</a>
                        </div>
                    </div>
                </div>
            </div>
            <%}} else { %>
            <p style="font-size: xx-large; color: white" class="my-4 mx-5">Aucun produit disponible.</p>
            <% } %>
        </div>

        <button class="btn" style="background-color: #EE4900; position: fixed; top: 88%; right: 3%;">
            <a href="add-produit" style="color: white;">
                ADD PRODUIT
            </a>
        </button>

    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
