<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceuil</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        *{
            box-sizing: border-box;
            margin-top: 0%;
            margin-right: 0%;
        }
        .rech:focus{
            outline: #001620;
        }
        html{
            height: 100%;
        }
        body{
            display: flex;
            flex-direction: column;
            min-height: 100%;
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
            color: white;
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
        footer{
            margin-top: auto;
            color: white;
            width: 99%;
        }
        .co{
            height: 600px;
            width: 300px;
            background-color: #14242b;
            margin: 50px;
            border-radius: 15px;
            box-shadow: 0 0 20px rgba(255, 165, 0, 0.7);
            color: white;
        }
        .ti{
            margin-left: -1%;
        }
        .but{
            height: 40px;
            width: 100%;
            background-color: #EE4900;
            text-align: center;
            margin-top: 300px;
        }
        .but1{
            height: 40px;
            width: 80%;
            background-color: #EE4900;
            text-align: center;
            margin-top: 300px;
        }
        .tou{
            display: flex;
        }
        .li{
            color: #EE4900;
            margin-left: 300px;
        }


        .progress-bar {
            width: 300px;
            height: 30px;
            border: 1px solid #EE4900;
            position: relative;
            overflow: hidden;
        }

        .progress-bar-inner {
            width: 0;
            height: 100%;
            background-color: #EE4900;
            transition: width 2s ease; /* Réglage de la vitesse de l'animation */
        }
    </style>
</head>
<body style="background-color: #001620;">
<header>
    <nav style="margin-top: -4%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" width="150">
            <div class="container" style="margin-top: -9.1%; margin-left: 10%;">
                <div class="row">
                    <div class="col-sm" style="margin-left: 60%;">
                        <img class="mx-2 my-1" src="assets/img/account.png" style="cursor: pointer;" onclick="Verifier()" alt="compte" width="35">
                        <img class="mx-4" src="assets/img/shopping-basket.png" style="cursor: pointer;" alt="panier" onclick="window.location.href='panier'" width="35">
                    </div>
                    <div class="col-sm">
                        <input type="text"  class="rounded-4 rech" style="width: 250px; height: 40px;" >
                        <img src="assets/img/search.png" style="cursor: pointer; margin-left: 110%; margin-top: -28%;" alt="rech" width="30">
                    </div>
                </div>
            </div>
        </div>
        <div class="barre bg-light">
            <div class="row">
                <div class="col-2 element">
                    <a href="acceuil-user" >ACCEUIL</a>
                </div>
                <div class="col-3 element">
                    <a href="casques-souris">SOURIS ET CASQUES</a>
                </div>
                <div class="col-3 element">
                    <a href="clavier-imprimante">CLAVIERS ET IMPRIMANTES</a>
                </div>
                <div class="col-2 element">
                    <a href="ordinateur">ORDINATEUR</a>
                </div>
                <div class="col-2 element">
                    <a href="ecran">ECRAN</a>
                </div>
            </div>
        </div>
    </nav>
</header>
<div class="tou">
    <div class="co">
        <h1 class="ti text-center">COMPTE</h1>
        <%
            String nom = (String) request.getAttribute("nom");
            if (nom != null) {
        %>
        <p class="large">Nom: <%= nom %></p>
        <%
            }
        %>
        <%
            String prenom = (String) request.getAttribute("prenom");
            if (prenom != null) {
        %>
        <p class="large">Prenom: <%= prenom %></p>
        <%
            }
        %>
        <%
            String mail = (String) request.getAttribute("mail");
            if (mail != null) {
        %>
        <p class="large">Email: <%= mail %></p>
        <%
            }
        %>

        <div class="but" style="margin-top: 30%;"><a>COMMANDES</a></div>

        <a href="deconnexion"><button class="btn but1" style="margin-top: 20%; margin-left: 10%; color: white">Déconnexion</button></a>
    </div>
    <div class="container">
        <h1 class="li">Liste des commandes</h1>
        <div class="row" style="margin-top: 5%;">
            <% List<Map<String, Object>> listeCommandes = (List<Map<String, Object>>) request.getAttribute("listeCommandes"); %>
            <% if (listeCommandes != null && !listeCommandes.isEmpty()) { %>
            <% for (Map<String, Object> commande : listeCommandes) { %>
            <div class="col12" style="color: white; border: 1px solid #EE4900; border-radius: 1%; width: 95%; margin-top: 2%;">
                <h4>IDCOMMANDE: <%= commande.get("idCmd") != null ? commande.get("idCmd") : "N/A" %>  </h4>
                <ul style="color: white;">
                    <% List<Map<String, String>> produits = (List<Map<String, String>>) commande.get("produits"); %>
                    <% if (produits != null && !produits.isEmpty()) { %>
                    <% for (Map<String, String> produit : produits) { %>
                    <li style="font-size: x-large;"><img src="photoProduit/<%=produit.get("photo") != null ? produit.get("photo") : "N"%>" width="60"><%= produit.get("nomproduit")  != null ? produit.get("nomproduit") : "N/A" %> , <%= produit.get("prixunitproduit") != null ? produit.get("prixunitproduit") : "N/A" %>, <%= produit.get("quantite") != null ? produit.get("quantite") : "N/A" %></li>
                    <% } %>
                    <% } else { %>
                    <p style="color: white; font-size: x-large; margin-left: 15%;">Aucun produit trouvé.</p>
                    <% } %>
                </ul>
                <h4>Total:  <%= commande.get("total") != null ? commande.get("total") : "N/A" %></h4>
                <h4>Statut:  <div class="progress-bar" style="border-radius: 19px; margin-left: 9%; margin-top: -3%;">
                    <div class="progress-bar-inner" id="progressBar<%=commande.get("idCmd")%>" ><%= commande.get("status") != null ? commande.get("status") : "N/A" %></div>
                </div>
                </h4>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        var progressBar = document.getElementById('progressBar<%=commande.get("idCmd")%>');
                        var progress = 0;
                        let statuts="<%= commande.get("status") %>";

                        if (statuts=="en cours"){
                            function updateProgressBar() {
                                if (progress <= 50) {
                                    progressBar.style.width = progress + '%';
                                    progress++;
                                    requestAnimationFrame(updateProgressBar);
                                }
                            }
                            updateProgressBar();
                        }else if(statuts=="terminer"){
                            function updateProgressBar() {
                                if (progress <= 100) {
                                    progressBar.style.width = progress + '%';
                                    progress++;
                                    requestAnimationFrame(updateProgressBar);
                                }
                            }
                            updateProgressBar();
                        }

                    });
                </script>
            </div>
                    <% } %>
            <%} else { %>
            <p style="font-size: xx-large; color: white; margin-top: 10%">Aucune detail de commande trouvée.</p>
            <% } %>
        </div>
    </div>
</div>
<footer>
    <div class="row" style="background-color: #14242B;">
        <div class="col-6 mx-4">
            <h2 class="mx-5">BRANDS</h2>
        </div>
        <div class="col">
            <h2>NEWSLETTER</h2>
        </div>
        <div class="container">
            <div class="row" style="background-color: #254250;">
                <div class="col-6 mx-4 my-2">
                    <ul class="mx-5">
                        <li><a href="https://fr.jbl.com/?countrySelector=yes&ged=off">JBL</a></li>
                        <li><a href="https://www.bose.com/home">BOSE</a></li>
                        <li><a href="https://www.philips.fr/c-m-so/casque">PHILLIPS</a></li>
                        <li><a href="https://www.lenovo.com/za/en/laptops/c/Laptops#type=TYPE_ATTR1">LENOVO</a></li>
                        <li><a href="https://www.hp.com/emea_africa-en/home.html">HP</a></li>
                    </ul>
                </div>
                <div class="col my-2">
                    <p>Veuillez entrer votre Email pour vous abonner nôtre
                        newsletter et être informé de nos nouveautés en matière
                        de produit.
                    </p>
                    <div class="col-sm">
                        <form>
                            <input type="text" id="email"  class="rounded-4 rech" style="width: 250px; height: 40px;" >
                            <button onclick="sendSubscribe()" style="width: 20%; height: 40px; margin-left: 5%;  background-color: #EE4900; border: none;" class="rounded-5"><a style="color: white;"> SUBSCRIBE</a></button>
                        </form>
                    </div>
                    <p class="my-3 mx-5">2023 Copyright</p>
                </div>
            </div>
        </div>
    </div>
</footer>
<script>
    function Verifier(){
        <%if (session != null) {
           String Id = (String) session.getAttribute("id_user");
           if (Id!= null){%>
        window.location.href="account-user"
        <%}else{ %>
        window.location.href="connexion"
        <% }%>
        <% }else{ %>
        window.location.href="connexion"
        <% }%>
    }

    // Fonction pour envoyer le subscriber
    function sendSubscribe(event) {
        event.preventDefault();

        var email = document.getElementById('email').value;

        $.ajax({
            type: 'GET',
            url: 'send-subscriber',  // Remplacez par l'URL appropriée sur votre serveur
            contentType: 'application/json',
            data: {
                Email: email
            },
            success: function(response) {
                // Gérez la réponse réussie ici
                Swal.fire({
                    title: "Souscription a la newsletter valider!",
                    icon: "success"
                });
                var maile = document.getElementById('email');
                maile.value="";
            },
            error: function(error) {
                // Gérez les erreurs ici
                console.error('Erreur lors de l\'envoi de la soubscription:', error);
            }
        });
    }
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
