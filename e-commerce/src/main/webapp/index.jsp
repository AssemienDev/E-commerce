<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        body{
            background-color: #001620;
        }
        .loader {
            transform: rotateZ(45deg);
            perspective: 1000px;
            border-radius: 50%;
            width: 480px;
            height: 480px;
            color: #fff;
        }
        .loader:before,
        .loader:after {
            content: '';
            display: block;
            position: absolute;
            top: 2%;
            left: 25%;
            width: inherit;
            height: inherit;
            border-radius: 50%;
            transform: rotateX(70deg);
            animation: 1s spin linear infinite;
        }
        .loader:after {
            color: #FF3D00;
            transform: rotateY(70deg);
            animation-delay: .4s;
        }

        @keyframes rotate {
            0% {
                transform: translate(-50%, -50%) rotateZ(0deg);
            }
            100% {
                transform: translate(-50%, -50%) rotateZ(360deg);
            }
        }

        @keyframes rotateccw {
            0% {
                transform: translate(-50%, -50%) rotate(0deg);
            }
            100% {
                transform: translate(-50%, -50%) rotate(-360deg);
            }
        }

        @keyframes spin {
            0%,
            100% {
                box-shadow: .2em 0px 0 0px currentcolor;
            }
            12% {
                box-shadow: .2em .2em 0 0 currentcolor;
            }
            25% {
                box-shadow: 0 .2em 0 0px currentcolor;
            }
            37% {
                box-shadow: -.2em .2em 0 0 currentcolor;
            }
            50% {
                box-shadow: -.2em 0 0 0 currentcolor;
            }
            62% {
                box-shadow: -.2em -.2em 0 0 currentcolor;
            }
            75% {
                box-shadow: 0px -.2em 0 0 currentcolor;
            }
            87% {
                box-shadow: .2em -.2em 0 0 currentcolor;
            }
        }

    </style>
</head>
<body>
<div>
    <span class="loader"></span>
</div>
<script>
    setTimeout(function() {
        window.location.href = "acceuil-user";
    }, 1500);
</script>
</body>
</html>