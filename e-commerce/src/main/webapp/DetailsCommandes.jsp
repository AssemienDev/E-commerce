<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %><!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Commandes</title>
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
        }*
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
                <div class="col-2 element text-center">
                    <a href="produit-admin" style="color: #EE4900">PRODUITS</a>
                </div>
                <div class="col-2 actif element text-center">
                    <a href="commandes" style="color: white;">COMMANDES</a>
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
<div class="principale">
    <h3 style="color: white; margin-top: 2%; margin-left: 5%;"><a href="commandes" style="color: #EE4900;">COMMANDES</a>/<a  style="color: silver;">DETAIL COMMANDE</a></h3>
    <div>
        <div>
            <% List<Map<String, Object>> listeCommandes = (List<Map<String, Object>>) request.getAttribute("listeCommandes"); %>

            <% if (listeCommandes != null && !listeCommandes.isEmpty()) { %>
            <% for (Map<String, Object> commande : listeCommandes) { %>
            <ul style="width: 92%;font-size: x-large; color: white; margin-left: 5%; margin-top: 2%;">
                <ul>Nom: <%= commande.get("nom") %></ul>
                <ul>Prenom: <%= commande.get("prenom") %></ul>
                <ul>Email: <%= commande.get("email") %></ul>
                <ul>Addresse de livraison: <%= commande.get("adresse") %></ul>
                <ul>Numéro de téléphone: <%= commande.get("num") %></ul>
                <ul>Date de la commande: <%= commande.get("date") %></ul>
                <ul>Moyens de paiement: <%= commande.get("paiement") %></ul>
                <ul style="display: flex;">
                    Statuts de la commande: <p id="base-info" style="display: flex; margin-left: 0.5%;"> <%= commande.get("status") %> <button class="btn" id="not-info" style="background-color: #EE4900; color: #001620; font-weight: bold; margin-left: 5%;" > modifier </button></p>
                    <div id="info" style="display: none; margin-left: 1%;">
                        <form action="details-commandes" method="post">
                            <input value="<%= commande.get("idCommande") %>" name="idCommande" type="text" hidden="hidden" />
                            <input type="radio" name="choix" value="en cours" id="num1" required>En cours
                            <input type="radio" name="choix" value="terminer" id="num2" required>Terminer
                            <input style="margin-left: 25%; margin-top: 4%; background-color: #EE4900; color: #001620;" class="btn" type="submit" value="valider">
                        </form>
                    </div>
                </ul>
            </ul>
        </div>
        <% List<Map<String, String>> produits = (List<Map<String, String>>) commande.get("produits"); %>
        <% if (produits != null && !produits.isEmpty()) { %>
        <% for (Map<String, String> produit : produits) { %>
        <div style="width: 75%; color: white; font-size: x-large; margin-left: 15%;">
            <p>Nom du produit: <%= produit.get("nomproduit") %></p>
            <p>Prix unitaire: <%= produit.get("prixunitproduit") %></p>
            <p>Quantité: <%= produit.get("quantite") %></p>
        </div>
        <% } %>
        <% } else { %>
        <p style="color: white; font-size: x-large; margin-left: 15%;">Aucun produit trouvé.</p>
        <% } %>
        <div style="color: white; font-size: x-large; margin-left: 20%;">
            <p>Total: <%= commande.get("total") %></p>
        </div>
    </div>
    <% } %>
    <% } else { %>
    <p style="font-size: xx-large; color: white; margin-top: 10%; margin-left: 5%">Aucune detail de commande trouvée.</p>
    <% } %>

</div>

</div>
<script src="https://code.jquery.com/jquery-3.7.1.js" integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
<script type="text/javascript">
    $('#not-info').on("click", function (){
        $("#base-info").css({
            'display':'none',
        })
        $("#info").css({
            'display':'flex',
        })
    })
</script>
</body>
</html>

