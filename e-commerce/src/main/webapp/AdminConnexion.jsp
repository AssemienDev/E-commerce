<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion Administrateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <style>
        *{
            box-sizing: border-box;
            margin-top: 0%;
            margin-right: 0%;
        }
        .box-inscription{
            margin-top: -5%;
            width: 60%;
            height: 450px;
            box-shadow: 2px -5px 2px -10px #EE4900;
            box-shadow: -1px 0px 2px 3px #EE4900;
            border-radius: 1%;
        }
        .info{
            font-weight: bold;
            color: white;
            margin-left: 10%;
            position: absolute;
            top: 28%;
        }
        label{
            color: white;
        }
        .formulaire{
            position: relative;
            top: 150px;
            left: 22%;
            font-size: 25px;
        }
        input:hover{
            outline: none;
        }
    </style>
</head>
<body style="background-color: #001620;">
<header>
    <nav style="margin-top: -5%;">
        <div>
            <img src="assets/img/logo.png" alt="logo" style="margin-left: 42%;" width="200">
        </div>
    </nav>
</header>
<div class="principale">
    <div class="container box-inscription">
        <h1 class="mx-5 info">CONNEXION ADMINISTRATEUR</h1>
        <%
            String erreur = (String) request.getAttribute("erreur");
            if (erreur != null) {
        %>
        <p class="text-center" style="color: red;"><%= erreur %></p>
        <%
            }
        %>
        <form class="formulaire" method="post" action="hello-servlet">
        <div class="form-group row ">
                <label for="staticEmail" class="col-sm-2 col-form-label fw-bold " style="margin-top: -1%;">Email:</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control w-50" name="mail" id="staticEmail" required>
                </div>
            </div>
            <div class="form-group row my-5">
                <label for="inputPassword" class="col-sm-2 col-form-label fw-bold" style="margin-top: -1%;">Password:</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control w-50" name="passe" id="inputPassword" required>
                </div>
            </div>
            <input type="submit" class="btn" value="CONNEXION" style="background-color: #EE4900; color: white; margin-left: 20%; width: 22%;">
        </form>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
</body>
</html>
