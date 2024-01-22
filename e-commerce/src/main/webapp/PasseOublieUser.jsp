<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>connexion</title>
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
            background-color: #001620;
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
        footer{
            margin-top: auto;
            color: white;
            width: 99%;
        }
        .form{
            width: 550px;
            height: 450px;
            background-color: #14242b;
            margin-left: 30%;
            border-radius: 10px;
            box-shadow: #EE4900;
            color: white;
            margin-top: 30px;
            margin-bottom: 30px;
        }
        button{
            background-color: #EE4900;
            color: white;
            width: 120px;
            height: 30px;
            border-radius: 10px;
        }
        label{
            margin-left: 60px;
        }
        a{
            text-decoration: none;
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
                        <img class="mx-4" src="assets/img/shopping-basket.png" style="cursor: pointer;" alt="panier" onclick="window.location.href='panier'" width="35">
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
<div class="form">
    <form class="text-center container" action="passe-oublier" method="post">
        <h2 class="text-center">MOTS DE PASSE OUBLIE</h2>
        <%
            String erreur = (String) request.getAttribute("erreur");
            if (erreur != null) {
        %>
        <p class="text-center" style="color: red;"><%= erreur %></p>
        <%
            }
        %>
        <div class="mb-3 row py-3">
            <label for="inputEmail" class="col-sm-2 col-form-label " >Email</label>
            <div class="col-auto">
                <input type="email" class="form-control" name="mail" required id="inputEmail">
            </div>
        </div>
        <div class="mb-3 row">
            <label for="inputPassword" class="col-sm-2 col-form-label">CodeSecret</label>
            <div class="col-auto">
                <input type="password" class="form-control" name="secret" required id="inputPassword">
            </div>
        </div>
        <div class="p py-3"><a href="inscription">s'inscrire</a></div>

        <div class="bouton">
            <button class="rounded-5" type="submit">Valider</button>
        </div>
    </form>
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
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
