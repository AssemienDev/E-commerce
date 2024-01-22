<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Produit</title>
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
        .box-inscription{
            margin-top: 5%;
            width: 50%;
            height: 300px;
            box-shadow: 2px -5px 2px -10px #EE4900;
            box-shadow: -1px 0px 2px 3px #EE4900;
            border-radius: 1%;
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
                <div class="col-2  element text-center">
                    <a href="produit-admin" style="color: #EE4900" >PRODUITS</a>
                </div>
                <div class="col-2 element text-center">
                    <a href="commandes" style="color: #EE4900">COMMANDES</a>
                </div>
                <div class="col-3 actif element text-center">
                    <a href="avis"  style="color:white;">COMMENTAIRES</a>
                </div>
                <div class="col-2 element text-center">
                    <a href="subscriber" style="color: #EE4900">SUBSCRIBER</a>
                </div>
            </div>
        </div>
    </nav>
</header>


<div class="principale">
    <h3 style="color: white; margin-top: 2%; margin-left: 5%;"><a href="avis" style="color: #EE4900;">COMMENTAIRES</a>/<a  style="color: silver;">DELETE AVIS</a></h3>
    <div class="container box-inscription" style="color: white;">
        <%
            String reponse = (String) request.getAttribute("reponse");
            if (reponse == "Commentaire Supprimer") {
        %>
        <p class="fw-bold text-center my-5"  style="color: dodgerblue; font-size: xx-large;"><%= reponse %></p>
        <%}else if (reponse == "Commentaire Non Supprimer"){%>
        <p class="fw-bold text-center my-5" style="color: red; font-size: xx-large;"><%= reponse %></p>
        <%}%>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>

