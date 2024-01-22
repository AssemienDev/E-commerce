<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Page 2</title>
</head>
<body>
<h1>Page d'erreur BD</h1>

<%-- Afficher l'erreur le cas échéant --%>
<%
    String erreur = (String) request.getAttribute("erreur");
    if (erreur != null) {
%>
<p>Erreur : <%= erreur %></p>
<%
    }
%>
</body>
</html>
