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
            width: 75%;
            height: 640px;
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
                    <div class="col-sm" style="margin-left: 55%; margin-top: 3%;">
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
                <div class="col-2 actif element text-center">
                    <a href="produit-admin" style="color:white;">PRODUITS</a>
                </div>
                <div class="col-2 element text-center">
                    <a href="commandes">COMMANDES</a>
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
    <h3 style="color: white; margin-top: 2%; margin-left: 5%;"><a href="produit-admin" style="color: #EE4900;">PRODUITS</a>/<a  style="color: silver;">ADD PRODUITS</a></h3>
    <div class="container box-inscription" style="color: white;">
        <%
            String valide = (String) request.getAttribute("valide");
            if (valide != null) {
        %>
        <p class="fw-bold mx-2 my-1" style="color: dodgerblue; font-size: x-large;"><%= valide %></p>
        <%
            }
        %>
        <h1 class="mx-5 info" style="margin-top: 3%;">ADD PRODUIT</h1>
        <form class="formulaire" style="margin-left: 20%;"  method="post" action="add-produit" enctype="multipart/form-data">
            <div class="my-5">
                <div class="form-group row " style="margin-left: -15%;">
                    <label for="nom" class="col-sm-2 col-form-label fw-bold " style="margin-top: -1%;">NOM:</label>
                    <div class="col-sm-10" style="margin-left: -8%;">
                        <input type="text" class="form-control" style="width: 30%;" name="nom" id="nom" required>
                    </div>
                </div>
                <div class="form-group row " style="margin-left: 35%; margin-top: -3.5%;">
                    <label for="prix" class="col-sm-2 col-form-label fw-bold " style="margin-top: -1%; margin-left: -7%;">PRIX:</label>
                    <div class="col-sm-10" style="margin-left: -2%;">
                        <input type="text" class="form-control" style="width: 60%;" name="prix" id="prix" required>
                    </div>
                </div>
            </div>
            <div class="my-5">
                <div class="form-group row " style="margin-left: -15%;">
                    <label for="description" class="col-sm-2 col-form-label fw-bold " style="margin-top: -1%; margin-left: -6%;">DESCRIPTION:</label>
                    <div class="col-sm-10" style="margin-left: -2%;">
                        <textarea style="width: 30%;" class="form-control" id="description" name="description" rows="3" required></textarea>
                    </div>
                </div>
                <div class="form-group row " style="margin-left: 35%; margin-top: -8%;">
                    <label for="options" class="col-sm-2 col-form-label fw-bold w-50" style="margin-top: -1%; margin-left: 20%;">CATEGORIE:</label>
                    <div class="col-sm-10" style="margin-left: 9%;">
                        <select style="background-color: white; border-radius: 2px; width: 58%;" id="options" name="categorie" required>
                            <option value="souris">SOURIS</option>
                            <option value="casque">CASQUE</option>
                            <option value="clavier">CLAVIER</option>
                            <option value="imprimante">IMPRIMANTE</option>
                            <option value="ordinateur">ORDINATEUR</option>
                            <option value="ecran">ECRAN</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="my-5">
                <div class="form-group row " style="margin-left: -15%;">
                    <label for="photo" class="col-sm-2 col-form-label fw-bold w-50 " style="margin-top: -1%; margin-left: 13%;">PHOTO PRODUIT:</label>
                    <div class="col-sm-10" style="margin-left: 9%;">
                        <input class="form-control" required type="file" id="photo" name="photo" style="width: 30%;" accept=".jpg, .jpeg, .png">
                    </div>
                </div>
                <div class="form-group row " style="margin-left: 35%; margin-top: -7%;">
                    <label for="couleur1" class="col-sm-2 col-form-label fw-bold w-50" style="margin-top: -1%; margin-left: 20%;">COULEUR1:</label>
                    <div class="col-sm-10" style="margin-left: 9%;">
                        <input type="text" class="form-control" style="width: 60%;" required name="couleur1" id="couleur1">
                    </div>
                </div>
            </div>
            <div class="my-5">
                <div class="form-group row " style="margin-left: -15%;">
                    <label for="couleur2" class="col-sm-2 col-form-label fw-bold w-50" style="margin-top: -1%;margin-left: 15%;">COULEUR2:</label>
                    <div class="col-sm-10" style="margin-left: 9%;">
                        <input type="text" class="form-control" style="width: 30%;" name="couleur2" id="couleur2">
                    </div>
                </div>
                <div class="form-group row " style="margin-left: 35%; margin-top: -5.5%;">
                    <label for="couleur3" class="col-sm-2 col-form-label fw-bold w-50 " style="margin-top: -1%; margin-left: 22%;">COULEUR3:</label>
                    <div class="col-sm-10" style="margin-left: 9%;">
                        <input type="text" class="form-control" style="width: 60%;" name="couleur3" id="couleur3">
                    </div>
                </div>
            </div>
            <input type="submit" class="btn fw-bold" value="ENREGISTRER" style="background-color: #EE4900; color: white; margin-left: 20%; width: 22%;">
        </form>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>

