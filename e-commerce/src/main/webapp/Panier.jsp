<%@ page import="com.example.ecommerce.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Panier</title>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">

    <style>

        *{
            box-sizing: border-box;
            margin-top: 0%;
            margin-right: 0%;
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

        footer{
            margin-top: auto;
            color: white;
            width: 99%;
        }

        body{
            background-color: #14242B;
        }

        /*style du global de div*/
        .py-4{
            background-color: #001620;
            border: 1px solid #EE4900;
            border-radius: 10px;
            width: 70%;
            margin-bottom: 50px;
            margin-top: 50px;
        }


        /*style des inputs*/

        h2 {
            margin-right: 70%;
            margin-bottom: 5%;
        }

        label, h2, h3, .mb-3 p, .prix p{
            color: white;
        }
        .p a{
            color:#EE4900;
        }

        .divGlobale{
            display: flex;

            /*div input et label*/
            .mb-3 {
                margin-left: 2%;
                margin-top: 10px;
            }
        }


        /*btn orange s'inscrire*/
        .rounded-5 {
            width: 20%;
            height: 40px;
            background-color: #EE4900;
            border: none;
            margin-left: 60%;
            color: white;
        }

        .mb-3 img{
            height: 150px;
            width: 150px;
        }

        button{
            margin-left: 29%;
            background-color: #EE4900;
            border-radius: 10px;
            width: 50px;
            height: 50px;
        }

        .prix{
            margin-right: 80%;
        }

        .quantity {
            display: flex;
            align-items: center;
            input {
                width: 60px;
                height: 50px;
                text-align: center;
                border: none;

            }

            p{
                font-size: 25px;
                margin-left: 60px;
                margin-bottom: 5px;
            }

        }

        #quantityDelete{
            height:  50px;
            width: 50px;
            margin-left: 70px;
        }

        .adjust-quantity {

            color: #fff;
            border: none;
            padding: 5px 10px;
            margin: 0;
            cursor: pointer;
        }


        #moins{
            border-top-right-radius: 0px;
            border-bottom-right-radius: 0px;
        }
        #plus{
            border-bottom-left-radius: 0px;
            border-top-left-radius: 0px;
        }

        a{
            text-decoration: none;
            text-align: center;
            color: white;
        }
    </style>
</head>

<body>

<header>
    <nav style="margin-top: -4%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" width="150">
            <div class="container" style="margin-top: -9.1%; margin-left: 10%;">
                <div class="row">
                    <div class="col-sm" style="margin-left: 60%;">
                        <img class="mx-2 my-1" src="assets/img/account.png" style="cursor: pointer;" onclick="Verifier()" alt="compte" width="35">
                        <img class="mx-4" src="assets/img/shopping-basket.png" onclick="window.location.href='panier'" style="cursor: pointer;" alt="panier" width="35">
                    </div>
                    <div class="col-sm">
                        <form action="recherche-prod" id="form1" method="post">
                            <input type="text"  class="rounded-4 rech" name="rechercher" style="width: 250px; height: 40px; margin-left: -25%" >
                            <img src="assets/img/search.png" style="cursor: pointer; margin-left: 85%; margin-top: -28%;" alt="rech" onclick="function seacrh() {
                form1 = document.getElementById('form1')
                form1.submit()
              }
              seacrh()" width="30">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="barre bg-light">
            <div class="row">
                <div class="col-2 element">
                    <a href="acceuil-user">ACCEUIL</a>
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

<div class="py-4 text-center container">
    <h2><strong>PANIER</strong></h2>

    <%List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");

        double total = 0;
        if (cart != null && !cart.isEmpty()) {
            for (CartItem item : cart) {
                total += (item.getQuantity() * item.getPrice());

        // Set the "total" attribute in the session
        session.setAttribute("total", total);
    %>
    <div class="divGlobale" style="background-color:#254250; margin-top: 2%;">
        <div class="mb-4 row py-2">
            <img src="photoProduit/<%= item.getPhoto() %>" alt="">
        </div>
        <div class="mb-3 row py-3">
            <h3><strong><%= item.getName() %></strong></h3>
            <p> Couleur : <%= item.getColor() %></p>
        </div>
        <div class="mb-3 row py-3">
            <div class="quantity">
                <button class="adjust-quantity" id="moins<%= item.getIde() %>" onclick="decrement('<%= item.getIde() %>','quantity<%= item.getIde() %><%= item.getColor() %>','<%= item.getColor() %>')">-</button>
                <input type="number" id="quantity<%= item.getIde() %><%= item.getColor() %>"  name="quantity" value="<%= item.getQuantity() %>" min="1">
                <button class="adjust-quantity" id="plus<%= item.getIde() %>" onclick="increment('<%= item.getIde() %>','quantity<%= item.getIde() %><%= item.getColor() %>','<%= item.getColor() %>')">+</button>
                <p><strong><%= item.getPrice() %>Fr</strong></p>
                <a href="delete-produit-panier?id=<%= item.getIde() %>&color=<%= item.getColor() %>"><img src="assets/img/delete.svg" id="quantityDelete" alt="delete"></a>
            </div>

        </div>
        <div class="mb-3 row py-3">

        </div>
        <div class="mb-3 row py-3">

        </div>
    </div>

    <%
        }%>
    <div class="prix">
        <p style="font-size: x-large; width: 100%">total : <%= total
        %>Frcfa</p>
    </div>
    <button class="rounded-5" type="submit" onclick="window.location.href='faire-commande'">Payer</button>
    <%} else {
    %>
    <p style="text-align: center; font-size: xx-large; margin-left: 15%; color: white">Votre panier est vide.</p>
    <%
        }
    %>

    <script>

        function increment(productId, quantityId, color) {
            var quantityInput = document.getElementById(quantityId);
                quantityInput.value = parseInt(quantityInput.value) + 1;
            updateQuantity(productId, quantityInput.value, color);
        }

        function decrement(productId, quantityId,color) {
            var quantityInput = document.getElementById(quantityId);
            var currentValue = parseInt(quantityInput.value);
            if (currentValue > 1) {
                    quantityInput.value = currentValue - 1;
                updateQuantity(productId, quantityInput.value, color);
            }
        }

        function reloadPage() {
            setTimeout(function () {
                window.location.href ="panier"
            }, 100);
        }

        function updateQuantity(productId, change, couleur) {
    $.ajax({
    type: "POST",
    url: "update-quantity", // L'URL de votre nouvelle servlet de mise à jour de quantité
    data: {
    productId: productId,
    change: change,
        color: couleur,
    },
    success: function (data) {
    // Mettez à jour l'affichage du panier ou effectuez d'autres actions nécessaires
    console.log("Quantité mise à jour avec succès");
        reloadPage();
                },
                error: function () {
                    console.log("Erreur lors de la mise à jour de la quantité");
                }
            });
        }


    </script>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>

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
                        <li><a href="https://www.apple.com/ci/macbook-pro/">APPLE</a></li>
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
