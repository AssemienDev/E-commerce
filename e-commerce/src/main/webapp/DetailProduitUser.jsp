<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Detail produit</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
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
        h1{
            margin-left: 45%;
            color: white;
            margin-top: 2%;
        }

        .un{
            height: 230px;
            width: 280px;
            margin: 20px;
            margin-left: 5%;
            margin-bottom: 15%;
        }

        .un img{
            height:180px;
        }


        .des{
            margin-left: 0%;
            color: #EE4900;
            margin-top: -20%;
        }
        .desc{
            color: white;
        }
        p{
            color: white;
            text-align: left;
            font-size: large;
        }
        button{
            margin-left: 29%;
            background-color: #EE4900;
            color: white;
            border-radius: 10px;
            width: 120px;
            height: 50px;
        }


        a{
            text-decoration: none;
            color: white;
        }
        .pr{
            display: flex;
        }
        .JBL{
            margin-left: 0%;
            margin-top: 40%;

        }
        .ajouter{
            margin-top: 8%;
            margin-left: 1%;
        }

        .pls{
            display: flex;
            margin-left: 111px;
            margin-top: 40px;
        }

        .prix{
            margin-bottom: 35px;
            margin-left: 22.1%;
            margin-top: -2.5%;
        }
        .tou{
            margin-left: 250px;
        }

        .quantity {
            display: flex;
            align-items: center;
            margin-left: 23%;
            input {
                width: 60px;
                height: 50px;
                text-align: center;
                border: none;
                border-radius: 10px;

            }

        }

        .adjust-quantity {
            color: #fff;
            border: none;
            padding: 5px 10px;
            margin: 0;
            cursor: pointer;
            width: 17%;
        }

        .color-options {
            margin-bottom: 50px;
            display:flex;

        }

        .color-option {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            margin-right: 10px;
            cursor: pointer;
        }

    </style>
</head>
<body style="background-color: #001620;">
<header style="z-index: 10">
    <nav style="margin-top: -4%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" width="150">
            <div class="container" style="margin-top: -9.1%; margin-left: 10%;">
                <div class="row">
                    <div class="col-sm" style="margin-left: 60%;">
                        <img class="mx-2 my-1" src="assets/img/account.png" style="cursor: pointer;" onclick="Verifier()"  alt="compte" width="35">
                        <img class="mx-4" src="assets/img/shopping-basket.png" style="cursor: pointer;" onclick="window.location.href='panier'" alt="panier" width="35">
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
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Objects" %>
<div id="base">
    <div class="pr">
        <% List<Map<String, String>> listeProduits = (List<Map<String, String>>) request.getAttribute("listeProduits");
            if (listeProduits != null && !listeProduits.isEmpty()) {
                for (Map<String, String> produit : listeProduits) { %>
        <img src="photoProduit/<%=produit.get("photo") %>" alt="publicité" height="40%" width="40%" style="margin-top: 1.5%;">
        <div class="tou" style="margin-top: -9%">
            <h1 class="JBL"><%= produit.get("nom") %></h1>
            <div class="pls">

                <div class="color-options">
                    <% if(!Objects.equals(produit.get("couleur1"), "aucun")){%>
                    <div class="color-option" style="background-color:  <%= produit.get("couleur1") %>;" id="coul1" onclick="changeColor( '<%= produit.get("couleur1") %>','coul1','coul2','coul3')"></div>
                    <%}%>

                    <% if(!Objects.equals(produit.get("couleur2"), "aucun")){%>
                    <div class="color-option" style="background-color: <%= produit.get("couleur2") %>; " id="coul2" onclick="changeColor('<%= produit.get("couleur2") %>','coul2','coul1','coul3')"></div>
                    <%}%>

                    <% if(!Objects.equals(produit.get("couleur3"), "aucun")){%>
                    <div class="color-option" style="background-color: <%= produit.get("couleur3") %>;" id="coul3" onclick="changeColor('<%= produit.get("couleur3") %>','coul3','coul2','coul1')"></div>
                    <%}%>


                </div>

            </div>
            <h1 class="prix"><%= produit.get("prix") %>Frcfa</h1>

            <div class="quantity">
                <button class="adjust-quantity" onclick="decrement()">-</button>
                <form action="add-panier" id="Formulaire"  method="post">
                    <input type="hidden" name="ide" value="<%= produit.get("ide") %>">
                    <input type="hidden" name="nom" value="<%= produit.get("nom") %>">
                    <input type="hidden" name="photo" value="<%=produit.get("photo") %>">
                    <input type="hidden"  name="prix" value="<%=produit.get("prix") %>">
                    <input type="hidden" id="color" name="color" value="as">
                    <input type="number" id="quantity" name="quantity" readonly value="1" min="1">
                </form>
                <button class="adjust-quantity" onclick="increment()">+</button>
            </div>
                <div class="ajouter">
                    <a onclick="valider()" style="cursor: pointer;">
                        <button class="btn w-25" style="background-color: #EE4900; color: white; font-size: large;">
                            <img src="assets/img/shopping-cart.png" alt="panier" width="35" >ajouter
                        </button>
                    </a>
                </div>
            <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
            <script>
                function increment() {
                    var quantityInput = document.getElementById('quantity');
                    quantityInput.value = parseInt(quantityInput.value) + 1;
                }

                function decrement() {
                    var quantityInput = document.getElementById('quantity');
                    var currentValue = parseInt(quantityInput.value);
                    if (currentValue > 1) {
                        quantityInput.value = currentValue - 1;
                    }
                }
                function changeColor(valeur, valeur2, valeur3, valeur4){
                    let coul1 = document.getElementById(valeur2);
                    let coul2 = document.getElementById(valeur3);
                    let coul3 = document.getElementById(valeur4);
                    let color = document.getElementById('color');
                    color.value=valeur;
                    if (valeur2 == 'coul1'){
                        coul2.style.opacity=0.2
                        coul3.style.opacity=0.2
                        coul1.style.opacity=1
                    }else if(valeur2 == 'coul2'){
                        coul2.style.opacity=0.2
                        coul3.style.opacity=0.2
                        coul1.style.opacity=1
                    }else if(valeur2 == 'coul3'){
                        coul2.style.opacity=0.2
                        coul3.style.opacity=0.2
                        coul1.style.opacity=1
                    }
                }

                function valider() {
                    let color = document.getElementById('color');
                    if (color.value == "as") {
                        Swal.fire({
                            title: "Veuillez choisir une couleur",
                            icon: "error"
                        });
                        return false;
                    }else{
                        Swal.fire({
                            title: "Produit ajouter au panier!",
                            icon: "success"
                        });
                        setTimeout(function (){// Récupérez l'élément de formulaire et soumettez-le
                            let myForm = document.getElementById('Formulaire');
                            myForm.submit();}, 1000)

                    }
                }
            </script>
        </div>
    </div>
    <div class="container" style="margin-top: 15%">
        <div class="row">
            <div class="col-8">
                <h1 class="des"> DESCRIPTION DU PRODUIT</h1>
                <h4 class="desc"><%= produit.get("nom") %></h4>
                <p><%= produit.get("description") %></p>
            </div>
            <div class="col" style="margin-top: -12%;">
                <h1 style="margin-left:18%; text-decoration: underline;">Commentaires</h1>
                <button onclick="afficher()" class="btn w-50" style="background-color: #EE4900;color: white; margin-top: 5%;">Voir Commentaire</button>
                <form>
                    <div class="form-group" id="FormComment" style="margin-top: 10%;">
                        <label for="exampleFormControlTextarea1" style="color: white;">Votre commentaire:</label>
                        <textarea class="form-control" id="exampleFormControlTextarea1" style="resize: none;" rows="2"></textarea>
                        <button onclick="verifComment(event,'<%= produit.get("ide") %>','<%= session.getAttribute("id_user")%>')" class="btn mb-2" style="margin-top: 5%; background-color: #EE4900; color: white;">Envoyer</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%}} else { %>
    <p style="font-size: xx-large; color: white" class="my-4 mx-5">Aucun produit disponible.</p>
    <% } %>
    <h1>Pour Toi</h1>
    <div class="container">

            <div class="row">
                <% List<Map<String, String>> listeAllProduits = (List<Map<String, String>>) request.getAttribute("listeAllProduits");
                    if (listeAllProduits != null && !listeAllProduits.isEmpty()) {
                        for (Map<String, String> produitAll : listeAllProduits) { %>
                <div class="col-2 un all">
                    <div class="col-12" style="background-color: white;">
                        <img src="photoProduit/<%=produitAll.get("photo") %>" class="w-100" alt="un">
                        <p style="color: #001620;"><%= produitAll.get("nom") %></p>
                    </div>
                    <div class="row"  style="margin-top:-6%; ">
                        <div class="col-6">
                            <a href="detail-produit?id=<%= produitAll.get("ide") %>"><button class="btn rounded-0" style="color: #EE4900; background-color: #01090e;width: 110%; margin-left: 0%; height: 39px;">Plus d'info</button></a>
                        </div>
                        <div class="col-3" style="background-color: #EE4900; color: #001620; width: 45%;height:
    38px;"><p style="height: 50px;"><%= produitAll.get("prix") %>FRCFA</p></div>
                    </div>
                </div>
                <%}} else { %>
                <p style="font-size: xx-large; color: white" class="my-4 mx-5">Aucun produit disponible.</p>
                <% } %>
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
                                <button onclick="sendSubscribe(event)" style="width: 20%; height: 40px; margin-left: 5%;  background-color: #EE4900; border: none;" class="rounded-5"><a style="color: white;"> SUBSCRIBE</a></button>
                            </form>
                        </div>
                        <p class="my-3 mx-5">2023 Copyright</p>
                    </div>
                </div>
            </div>
        </div>
    </footer>
</div>

<!--Commenatire produit-->
<div id="commentaire"  style="margin-left: 20%; display: none;">

    <div class="container">
        <div class="row">

            <div class="col-6">
                <h1 style="margin-left:18%; text-decoration: underline;">Commentaires</h1>
            </div>
            <div class="col-6">
                <button onclick="cacher()" class="btn w-25" style="background-color: #EE4900;color: white; font-size: x-large; margin-top: 5%;">fermer</button>
            </div>
            <% List<Map<String, String>> listeAllComment = (List<Map<String, String>>) request.getAttribute("listeCommentaires");
                if (listeAllComment != null && !listeAllComment.isEmpty()) {
                    for (Map<String, String> commentAll : listeAllComment) { %>
            <div class="col-6">
                <p><%= commentAll.get("texte") %></p>
                <h5 style="color: #EE4900;"><%= commentAll.get("date") %> Fait par <%= commentAll.get("auteur") %></h5>
            </div>
            <%}} else { %>
            <p style="font-size: x-large; color: white" class="text-center">Aucun Commentaire disponible.</p>
            <% } %>
        </div>
    </div>

</div>

<script>
    function afficher(){
        var commentaire = $('#commentaire');
        var base = $('#base');

        // Cacher la base avec une animation de fondu
        base.fadeOut(500, function() {
            // Afficher le commentaire après que la base a été cachée
            commentaire.fadeIn(500);
        });
    }
    function cacher(){
        var commentaire = $('#commentaire');
        var base = $('#base');

        // Cacher la base avec une animation de fondu
        base.fadeIn(500, function() {
            // Afficher le commentaire après que la base a été cachée
            commentaire.fadeOut(500);
        });
    }


    function verifComment(event, productId, userId){
        event.preventDefault();

        verifyUserOrder(productId, userId);
    }


    // Fonction pour vérifier la commande côté client
    function verifyUserOrder(productId, userId) {
        $.ajax({
            url: 'verif-order', // Remplacez par l'URL de votre servlet de vérification côté serveur
            method: 'POST',
            data: { productId: productId, userId: userId },
            success: function (response) {
                // La réponse doit être gérée côté client
                if (response === 'success') {
                    // L'utilisateur a passé une commande, vous pouvez maintenant envoyer le commentaire
                    sendComment(productId);
                } else {
                    // Affichez un message d'erreur à l'utilisateur
                    Swal.fire({
                        title: "Vous devez passer une commande pour ce produit avant d\'envoyer un commentaire!",
                        icon: "error"
                    });
                }
            },
            error: function () {
                // Gérez les erreurs si la vérification échoue
                alert('Une erreur s\'est produite lors de la vérification.');
            }
        });
    }

    // Fonction pour envoyer le commentaire
    function sendComment(Ide) {


        var productId = Ide;  // Remplacez par la vraie valeur
        var userId = '<%= session.getAttribute("nom") %>'+' <%= session.getAttribute("prenom") %>';  // Remplacez par la vraie valeur
        var commentaire = $('#exampleFormControlTextarea1').val();


        $.ajax({
            type: 'GET',
            url: 'save-order',  // Remplacez par l'URL appropriée sur votre serveur
            contentType: 'application/json',
            data: {
                productId: productId,
                userId: userId,
                commentaire: commentaire
            },
            success: function(response) {
                // Gérez la réponse réussie ici
                console.log('Commentaire envoyé avec succès:', response);
                Swal.fire({
                    title: "Commentaire envoyé avec succès",
                    icon: "success"
                });
                document.getElementById('exampleFormControlTextarea1').value="";
            },
            error: function(xhr, textStatus, errorThrown) {
                console.error('Erreur lors de l\'envoi du commentaire:', xhr.responseText);
                // Affichez le message d'erreur dans la console ou effectuez une autre action de gestion des erreurs
            }
        });
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
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
