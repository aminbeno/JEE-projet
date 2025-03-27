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
        /* Personnalisation */
        body {
            font-family: Arial, sans-serif;
        }
        .sidebar {
            height: 100vh;
            width: 250px;
            position: fixed;
            top: 56px; /* Hauteur de la navbar */
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
            margin-left: 260px; /* Largeur de la sidebar + espace */
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
    <h2>Bienvenue sur le tableau de bord</h2>
    <p>Sélectionnez une option dans le menu à gauche.</p>
</div>

</body>
</html>
