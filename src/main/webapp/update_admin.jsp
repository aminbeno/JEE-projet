<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fpt.example.dao.AdministrateurDAO" %>
<%@ page import="fpt.example.entities.Administrateur" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="jakarta.servlet.RequestDispatcher" %>
<%@ page import="java.io.IOException" %>

<%
    // Vérifier si la session existe sans en créer une nouvelle
    HttpSession currentSession = request.getSession(false);


    if (currentSession == null || currentSession.getAttribute("administrateur") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Récupérer l'administrateur connecté
    Administrateur administrateur = (Administrateur) currentSession.getAttribute("administrateur");

    // Récupérer les paramètres du formulaire
    String nom = request.getParameter("nom");
    String email = request.getParameter("email");
    String motDePasse = request.getParameter("motDePasse");

    // Vérifier que les champs ne sont pas vides
    if (nom == null || email == null || nom.isEmpty() || email.isEmpty()) {
        request.setAttribute("error", "Tous les champs sont obligatoires.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("parametres.jsp");
        dispatcher.forward(request, response);
        return;
    }

    // Mettre à jour les informations de l'administrateur
    administrateur.setNom(nom);
    administrateur.setEmail(email);

    // Mise à jour du mot de passe uniquement si un nouveau est fourni
    if (motDePasse != null && !motDePasse.isEmpty()) {
        administrateur.setMotDePasse(motDePasse);
    }

    // Mettre à jour dans la base de données
    AdministrateurDAO adminDAO = new AdministrateurDAO();
    adminDAO.update(administrateur);

    // Mettre à jour la session avec les nouvelles informations
    session.setAttribute("administrateur", administrateur);

    // Retourner à la page des paramètres avec un message de succès
    request.setAttribute("message", "Les informations ont été mises à jour avec succès.");
    RequestDispatcher dispatcher = request.getRequestDispatcher("parametres.jsp");
    dispatcher.forward(request, response);
%>
