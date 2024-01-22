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


        .caroussel-container {
            position: relative;
            width: 100%;
            height: 443px;
            margin-top: 0.5%;
        }

        .caroussel {
            width: 100%;
            height: 100%;
            opacity: 1;
            transition: opacity 1s ease-in-out;
        }

        .dot-container {
            position: absolute;
            bottom: 10px;
            left: 50%;
            transform: translateX(-50%);
            display: flex;
        }

        .dot {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background-color: #001260;
            margin: 0 5px;
            cursor: pointer;
        }

        .active {
            background-color: #ee4900; /* Change this to the desired active color */
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
                        <img class="mx-2 my-1" src="assets/img/account.png" onclick="Verifier()" style="cursor: pointer;" alt="compte" width="35">
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
                    <a href="acceuil-user" >ACCEUIL</a>
                </div>
                <div class="col-3 element">
                    <a href="casques-souris" >SOURIS ET CASQUES</a>
                </div>
                <div class="col-3 element">
                    <a href="clavier-imprimante" >CLAVIERS ET IMPRIMANTES</a>
                </div>
                <div class="col-2 element">
                    <a href="ordinateur">ORDINATEUR</a>
                </div>
                <div class="col-2 actif element">
                    <a href="#" style="color:white;">ECRAN</a>
                </div>
            </div>
        </div>
    </nav>
</header>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>



<div class="caroussel-container">
    <img class="caroussel" name="slide">
    <div class="dot-container"></div>
</div>


<h1>Pour Toi</h1>
<div class="container">
    <div class="row">
        <% List<Map<String, String>> listeProduits = (List<Map<String, String>>) request.getAttribute("listeProduits");
            if (listeProduits != null && !listeProduits.isEmpty()) {
                for (Map<String, String> produit : listeProduits) { %>
        <div class="col-2 un all">
            <div class="col-12" style="background-color: white;">
                <img src="photoProduit/<%=produit.get("photo") %>" class="w-100" alt="un">
                <p style="color: #001620;"><%= produit.get("nom") %></p>
            </div>
            <div class="row"  style="margin-top:-6%; ">
                <div class="col-6">
                    <a href="detail-produit?id=<%= produit.get("ide") %>"><button class="btn rounded-0" style="color: #EE4900; background-color: #01090e;width: 110%; ">Plus d'info</button></a>
                </div>
                <div class="col-3" style="background-color: #EE4900; color: #001620; width: 45%;height:
38px;"><p style="height: 50px;"><%= produit.get("prix") %>FRCFA</p></div>
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
<script>
    let currentSlide = 0;
    let images = ['assets/img/pub.png', 'assets/img/pubcasque.jpg', 'assets/img/acer.jpg'];
    let time = 2000;

    function changeSlide(index) {
        document.querySelector('.caroussel').style.opacity = 0;
        document.querySelectorAll('.dot')[currentSlide].classList.remove('active');

        setTimeout(() => {
            document.slide.src = images[index];
            document.querySelector('.caroussel').style.opacity = 1;

            currentSlide = index;

            document.querySelectorAll('.dot')[currentSlide].classList.add('active');

            setTimeout(() => {
                changeSlide((currentSlide + 1) % images.length);
            }, time);
        }, 1000);
    }

    window.onload = function () {
        for (let i = 0; i < images.length; i++) {
            let dot = document.createElement('div');
            dot.classList.add('dot');
            dot.addEventListener('click', () => changeSlide(i));
            document.querySelector('.dot-container').appendChild(dot);
        }

        changeSlide(0);
    };
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>

