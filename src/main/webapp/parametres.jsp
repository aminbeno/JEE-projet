<%@ page import="fpt.example.entities.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 56px;
            left: 0;
            background-color: #343a40;
            padding-top: 15px;
        }
        .sidebar a {
            padding: 10px 15px;
            text-decoration: none;
            font-size: 16px;
            color: white;
            display: block;
            border-radius: 5px;
        }
        .sidebar a:hover {
            background-color: #495057;
        }
        .content {
            margin-left: 260px;
            padding: 20px;
        }
    </style>
</head>
<body>

<!-- Barre de navigation -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Admin Dashboard</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <a href="formation.jsp">🏫 Formation</a>
    <a href="etudiants.jsp">🎓 Étudiant</a>
    <a href="certificat.jsp">📜 Certificat</a>
    <a href="parametres.jsp">⚙️ Paramètres</a>
    <a href="logout.jsp">🚪 Déconnexion</a>
</div>

<!-- Contenu principal -->
<div class="content">
    <%
        // Vérifier si la session existe sans en créer une nouvelle
        HttpSession currentSession = request.getSession(false);

        if (currentSession == null || currentSession.getAttribute("administrateur") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }

        Administrateur administrateur = (Administrateur) currentSession.getAttribute("administrateur");
    %>

    <div class="container mt-4">
        <br><br><br>
        <h2 class="text-center mb-4">Paramètres du compte</h2>

        <!-- Affichage des messages -->
        <% if (request.getAttribute("message") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("message") %></div>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
        <% } %>

        <!-- Formulaire de modification -->
        <div class="card shadow p-4">
            <h4 class="text-center mb-3">Modifier les informations</h4>
            <form action="update_admin.jsp" method="post">
                <div class="mb-3">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" class="form-control" id="nom" name="nom" value="<%= administrateur.getNom() %>" required>
                </div>
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= administrateur.getEmail() %>" required>
                </div>
                <div class="mb-3">
                    <label for="motDePasse" class="form-label">Mot de Passe (laisser vide pour ne pas changer)</label>
                    <input type="password" class="form-control" id="motDePasse" name="motDePasse">
                </div>
                <button type="submit" class="btn btn-primary w-100">Mettre à jour</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
