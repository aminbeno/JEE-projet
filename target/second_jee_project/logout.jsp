<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<%
    // Récupérer la session existante (sans en créer une nouvelle)
    HttpSession sessionActive = request.getSession(false);

    // Vérifier si une session existe, puis l'invalider
    if (sessionActive != null) {
        sessionActive.invalidate(); // Supprime toutes les données de session
    }

    // Redirection vers la page de connexion après déconnexion
    response.sendRedirect("AdminLogin.jsp");
%>
