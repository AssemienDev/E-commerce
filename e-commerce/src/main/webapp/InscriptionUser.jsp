<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>

        body{
            background-color: #14242B;
        }

        /*style du global de form*/
        .py-4{
            background-color: #001620;
            border: 1px solid #EE4900;
            border-radius: 10px;
            width: 65%;
            margin-bottom: 50px;
            margin-top: 50px;
        }


        /*style des inputs*/
        .form-control{
            width: 300px;
        }

        h2 {
            margin-right: 70%;
            margin-bottom: 5%;
        }

        label, h2{
            color: white;
        }
        .p a{
            color:#EE4900;
        }

        .divGlobale{
            display: flex;
            /*div input et label*/
            .mb-3 {
                margin-left: 5%;
            }
        }

        .champ_inputPassword{
            margin-left: 20%;
        }

        /*btn orange s'inscrire*/
        .rounded-5 {
            width: 20%;
            height: 40px;
            background-color: #EE4900;
            border: none;
            color: white;
        }


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

<body>

<header>
    <nav style="margin-top: -4%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" width="150">
            <div class="container" style="margin-top: -9.1%; margin-left: 10%;">
                <div class="row">
                    <div class="col-sm" style="margin-left: 60%;">
                        <img class="mx-2 my-1" src="assets/img/account.png" style="cursor: pointer;"  onclick="Verifier()" alt="compte" width="35">
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
                <div class="col-2  element">
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

<form class="py-4 text-center container" method="post" action="inscription">
    <h2>INSCRIPTION</h2>
    <%
        String erreur = (String) request.getAttribute("erreur");
        if (erreur != null) {
    %>
    <p class="text-center" style="color: red;"><%= erreur %></p>
    <%
        }
    %>
    <div class="divGlobale">
        <div class="mb-3 row py-3">
            <label for="inputNom" class="col-sm col-form-label " >Nom</label>
            <div class="col-auto">
                <input type="text" name="nom" class="form-control" id="inputNom" required>
            </div>
        </div>
        <div class="mb-3 row py-3">
            <label for="inputPrenom" class="col-sm col-form-label">Prenom</label>
            <div class="col-auto">
                <input type="text" name="prenom" class="form-control" id="inputPrenom" required>
            </div>
        </div>
    </div>

    <div class="divGlobale">
        <div class="mb-3 row py-3">
            <label for="inputEmail" style="width: 10%;" class="col-sm col-form-label " >Email</label>
            <div class="col-auto">
                <input type="email" name="mail"  class="form-control" id="inputEmail" required>
            </div>
        </div>
        <div class="mb-3 row py-3">
            <label for="inputMot_secret" class="col-sm-2 col-form-label" style="margin-top: -10px;">Mot Secret</label>
            <div class="col-auto">
                <input type="password" name="secret" class="form-control" id="inputMot_secret" style="margin-left: 7px;" required>
            </div>
        </div>
    </div>

    <div class="mb-3 row champ_inputPassword">
        <label for="inputPassword" class="col-sm-2 col-form-label">Password</label>
        <div class="col-auto ">
            <input type="password" name="passe" class="form-control" id="inputPassword" required>
        </div>
    </div>

    <div class="p py-3"><a href="connexion">se connecter</a></div>
    <button class="rounded-5" type="submit">Inscription</button>
</form>
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