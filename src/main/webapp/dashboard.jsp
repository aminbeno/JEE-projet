<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tableau de Bord Administrateur</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: #ffffff; /* Fond blanc */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            overflow-x: hidden;
        }

        /* Navbar */
        .navbar {
            background: linear-gradient(90deg, #007bff, #0056b3);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            padding: 1rem 2rem;
        }
        .navbar-brand {
            font-weight: 700;
            font-size: 1.6rem;
            color: white;
        }
        .navbar-brand i {
            margin-right: 8px;
        }

        /* Sidebar */
        .sidebar {
            height: calc(100vh - 70px);
            width: 260px;
            position: fixed;
            top: 70px;
            left: 0;
            background: #f8f9fa;
            border-right: 1px solid rgba(0, 0, 0, 0.05);
            padding: 20px 15px;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
        }
        .sidebar .nav-link {
            color: #2c3e50;
            padding: 12px 20px;
            margin: 5px 0;
            border-radius: 10px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            font-weight: 600;
        }
        .sidebar .nav-link i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            color: #007bff;
        }
        .sidebar .nav-link:hover,
        .sidebar .nav-link.active {
            background: linear-gradient(90deg, #007bff, #0062cc);
            color: white;
        }
        .sidebar .nav-link:hover i,
        .sidebar .nav-link.active i {
            color: white;
        }

        /* Content */
        .content {
            margin-left: 260px;
            padding: 30px 40px;
            min-height: calc(100vh - 70px);
            transition: all 0.3s ease;
        }
        .welcome-card {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        .welcome-card h2 {
            color: #2c3e50;
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        .welcome-card p {
            color: #495057;
            font-size: 1.2rem;
            line-height: 1.6;
        }

        /* Responsive */
        @media (max-width: 991px) {
            .sidebar {
                left: -260px;
            }
            .sidebar.active {
                left: 0;
                z-index: 1000;
            }
            .content {
                margin-left: 0;
            }
            .navbar-toggler {
                display: block !important;
                border: none;
            }
            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3e%3cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e");
            }
        }
    </style>
</head>
<body>

<!-- Barre de navigation -->
<nav class="navbar navbar-expand-lg fixed-top">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fas fa-tachometer-alt"></i> Admin Dashboard</a>
        <button class="navbar-toggler" type="button" id="sidebarToggle">
            <span class="navbar-toggler-icon"></span>
        </button>
    </div>
</nav>

<!-- Sidebar -->
<div class="sidebar">
    <a href="formation.jsp" class="nav-link">
        <i class="fas fa-chalkboard-teacher"></i> Formations
    </a>
    <a href="etudiants.jsp" class="nav-link">
        <i class="fas fa-users"></i> Étudiants
    </a>
    <a href="certificat.jsp" class="nav-link">
        <i class="fas fa-certificate"></i> Certificats
    </a>
    <a href="parametres.jsp" class="nav-link">
        <i class="fas fa-cog"></i> Paramètres
    </a>
    <a href="logout.jsp" class="nav-link">
        <i class="fas fa-sign-out-alt"></i> Déconnexion
    </a>
</div>

<!-- Contenu principal -->
<div class="content">
    <div class="welcome-card">
        <h2>Bienvenue</h2>
        <p>Gérez efficacement vos formations, étudiants et certificats depuis ce tableau de bord. Sélectionnez une option dans le menu latéral pour commencer.</p>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.querySelector('.sidebar');
    const content = document.querySelector('.content');

    sidebarToggle.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        content.classList.toggle('shifted');
    });

    // Fermer la sidebar quand on clique à l'extérieur sur mobile
    document.addEventListener('click', (e) => {
        if (window.innerWidth <= 991 &&
            !sidebar.contains(e.target) &&
            !sidebarToggle.contains(e.target) &&
            sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });
</script>
</body>
</html>