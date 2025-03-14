<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="fpt.example.entities.Joueur, fpt.example.entities.Equipe" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Joueurs</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>

<div class="container">
    <h1>Gestion des Joueurs</h1>

    <!-- Formulaire d'ajout de joueur -->
    <form action="joueurServ" method="post" class="form-container">
        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom" required>

        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom" required>

        <label for="equipe">Équipe :</label>
        <select id="equipe" name="equipe" required>
            <option value="">-- Sélectionnez une équipe --</option>
            <%
                List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
                if (equipes != null) {
                    for (Equipe equipe : equipes) {
            %>
            <option value="<%= equipe.getId() %>"><%= equipe.getNom() %></option>
            <%
                    }
                }
            %>
        </select>

        <button type="submit" class="btn">Ajouter</button>
    </form>

    <!-- Liste des joueurs -->
    <h2>Liste des Joueurs</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Prénom</th>
            <th>Équipe</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Joueur> joueurs = (List<Joueur>) request.getAttribute("joueurs");
            if (joueurs != null && !joueurs.isEmpty()) {
                for (Joueur joueur : joueurs) {
        %>
        <tr>
            <td><%= joueur.getId() %></td>
            <td><%= joueur.getNom() %></td>
            <td><%= joueur.getPrenom() %></td>
            <td><%= (joueur.getEquipe() != null) ? joueur.getEquipe().getNom() : "Aucune" %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="empty-message">Aucun joueur trouvé.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="equipeServ" class="btn-link">Gérer les équipes</a>
</div>

</body>
</html>
