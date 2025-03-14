<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="fpt.example.entities.Equipe" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Gestion des Équipes</title>

</head>
<body>

<div class="container">
    <h1>Gestion des Équipes</h1>

    <!-- Formulaire d'ajout d'équipe -->
    <form action="equipeServ" method="post" class="form-container">
        <label for="nom">Nom de l'Équipe :</label>
        <input type="text" id="nom" name="nom" required>
        <button type="submit" class="btn">Ajouter</button>
    </form>

    <!-- Liste des équipes -->
    <h2>Liste des Équipes</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Nom</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Equipe> equipes = (List<Equipe>) request.getAttribute("equipes");
            if (equipes != null && !equipes.isEmpty()) {
                for (Equipe equipe : equipes) {
        %>
        <tr>
            <td><%= equipe.getId() %></td>
            <td><%= equipe.getNom() %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="2" class="empty-message">Aucune équipe trouvée.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <a href="joueurServ" class="btn-link">Gérer les joueurs</a>
</div>

</body>
</html>
