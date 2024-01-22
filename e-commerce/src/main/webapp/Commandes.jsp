<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
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
    <h2  style="color: white;" class="mx-5 my-3">Liste des Commandes</h2>
    <div class="container table-responsive my-4" style="width: 100%;">
        <table class="table">
            <thead class="table-dark">
            <tr>
                <th scope="col">Nom</th>
                <th scope="col">Prenom</th>
                <th scope="col">Numéro</th>
                <th scope="col">Date</th>
                <th scope="col">Status</th>
                <th scope="col">Action</th>
            </tr>
            </thead>
            <tbody>
            <% List<Map<String, String>> listeCommandes = (List<Map<String, String>>) request.getAttribute("listeCommandes");
                if (listeCommandes != null && !listeCommandes.isEmpty()) {
                    for (Map<String, String> commandes : listeCommandes) { %>
            <tr>
                <td><%= commandes.get("nom") %></td>
                <td><%= commandes.get("prenom") %></td>
                <td><%= commandes.get("num") %></td>
                <td><%= commandes.get("date") %></td>
                <td style="color: green"><%= commandes.get("status") %></td>
                <td><a style="color: #EE4900" href="details-commandes?id=<%= commandes.get("ide") %>">Plus d'info</a></td>
            </tr>
            <%}} else { %>
            <p style="font-size: xx-large; color: white">Aucune commande.</p>
            <% } %>
            </tbody>
        </table>
    </div>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
