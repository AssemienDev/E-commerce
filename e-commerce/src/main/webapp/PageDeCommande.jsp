<%@ page import="com.example.ecommerce.CartItem" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InfoLivraison</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/@sweetalert2/theme-dark@4/dark.css" rel="stylesheet">
    <script src="https://cdn.fedapay.com/checkout.js?v=1.1.7"></script>
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

        .form_MethodePaiement{
            margin-top: 35px;
            color: #EE4900;
        }

        /*div des boutons : deplacer vers le bas*/
        .div__btn{
            margin-top: 28px;
            .rounded-5{margin: 15px;
            }
        }




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

<form class="py-4 text-center container"  id="FormulaireCommande" method="post">
    <h2>INFORMATIONS LIVRAISON</h2>

    <%
        String idUser = (String) request.getAttribute("IdUser");
        if (idUser != null) {
    %>
    <input type="hidden" name="idUSer" value="<%=idUser%>">
    <%
        }
    %>

    <div class="divGlobale">

        <div class="mb-3 row py-3">
            <label for="inputTelephone" class="col-sm-2 col-form-label">Téléphone</label>
            <div class="col-auto">
                <input type="tel" class="form-control" id="inputTelephone" style="margin-left: 8px;" name="num" required>
            </div>
        </div>

        <div class="mb-3 row py-3">

            <%
                double total = (Double) request.getAttribute("Total");
                if (total != 0.0) {
            %>
            <label class="col-sm-2 col-form-label w-100" style="font-size: large;">Total: <%= total%>Frcfa</label>
            <input type="hidden" value="<%= String.valueOf(total)%>" id="total" name="totalPrix">
            <%
                }
            %>

        </div>
    </div>

    <div class="divGlobale">
        <div class="mb-3 row">
            <label for="inputVille" class="col-sm col-form-label">Ville</label>
            <div class="col-auto ">
                <input type="text" class="form-control" id="inputVille" name="ville" style="margin-left: 8px;" required>
            </div>
        </div>
        <div class="mb-3 row">
            <label for="inputQuartier" class="col-sm col-form-label">Quartier</label>
            <div class="col-auto">
                <input type="text" class="form-control" name="quartier" id="inputQuartier" required>
            </div>
        </div>
    </div>
    <div class="form_MethodePaiement">Voulez-vous payer ?</div>
    <div class="div__btn">
        <input type="hidden"  id="info" name="moypaiement">
        <button class="rounded-5" onclick="livraison()">
            A la livraison
        </button>
        <button class="rounded-5"  id="pay-btn"
                <%
                    String email = (String) session.getAttribute("email");
                    if (email != null) {
                %>
                data-customer-email="<%= email %>"
                <%
                    }
                %>

                <%
                    String nom = (String) session.getAttribute("nom");
                    if (nom != null) {
                %>
                data-customer-lastname="<%= nom %>"
                <%
                    }
                %>

                <%
                    String prenom = (String) session.getAttribute("prenom");
                    if (prenom != null) {
                %>
                data-customer-firstname = "<%= prenom %>"
                <%
                    }
                %>

                data-currency-iso="XOF"
                onclick="submitHandler(event)"

        >En ligne</button>
    </div>
</form>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.js"></script>
<script>


    function submitHandler(event) {
        event.preventDefault();

        FedaPay.init('#pay-btn', {
            public_key: 'pk_live_mjTar0FS1A0z5JJj0dJDSf_d',
            transaction: {
                amount: parseInt(document.getElementById('total').value),
                description: 'Acheter Les Produits du Panier'
            }
        });


    }


        function Enligne(){
        var formu = document.getElementById('FormulaireCommande')
        var info = document.getElementById('info')
        info.value="En ligne"
        formu.action="faire-commande"
        formu.submit()
        }


    function livraison(){
        var formu = document.getElementById('FormulaireCommande')

        var inputs = formu.getElementsByClassName('form-control');
        for (var i = 0; i < inputs.length; i++) {
            if (inputs[i].type !== 'submit' && inputs[i].type !== 'button' && inputs[i].value.trim() === '') {
                // Si un champ est vide, afficher un message d'erreur
                Swal.fire({
                    title: "Veuillez remplir tout les champs!",
                    icon: "error"
                });
                return; // Arrêter la soumission du formulaire
            }
        }
        var info = document.getElementById('info')
        info.value="A la livraison"
        formu.action="faire-commande"
        formu.submit()
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