<%@ page import="fpt.example.entities.Administrateur" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Paramètres du Compte</title>
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
        }
        .card {
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(0, 0, 0, 0.05);
            max-width: 550px;
            margin: 0 auto;
        }
        .card-header {
            background: linear-gradient(90deg, #007bff, #0056b3);
            padding: 1.5rem;
            border-bottom: none;
            border-radius: 20px 20px 0 0;
        }
        .card-header h4 {
            color: white;
            font-weight: 700;
            margin: 0;
            text-align: center;
        }
        .card-body {
            padding: 2.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            transition: all 0.3s ease;
        }
        .form-control:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.2);
        }
        .btn-primary {
            background: linear-gradient(90deg, #007bff, #0062cc);
            border: none;
            padding: 12px 35px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #0062cc, #004085);
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(0, 123, 255, 0.3);
        }
        .btn-primary i {
            margin-right: 8px;
        }
        .alert {
            border-radius: 10px;
            padding: 1rem;
            font-weight: 500;
            margin-bottom: 2rem;
        }
        .input-group-text {
            border-radius: 10px;
            background: #f8f9fa;
            border: 1px solid #ced4da;
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
    <a href="parametres.jsp" class="nav-link active">
        <i class="fas fa-cog"></i> Paramètres
    </a>
    <a href="logout.jsp" class="nav-link">
        <i class="fas fa-sign-out-alt"></i> Déconnexion
    </a>
</div>

<!-- Contenu principal -->
<div class="content">
    <%
        HttpSession currentSession = request.getSession(false);
        if (currentSession == null || currentSession.getAttribute("administrateur") == null) {
            response.sendRedirect("AdminLogin.jsp");
            return;
        }
        Administrateur administrateur = (Administrateur) currentSession.getAttribute("administrateur");
    %>

    <h2 class="mb-4 text-center">Paramètres du Compte</h2>

    <div class="card">
        <div class="card-header">
            <h4><i class="fas fa-user-cog me-2"></i> Modifier les Informations</h4>
        </div>
        <div class="card-body">
            <% if (request.getAttribute("message") != null) { %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle me-2"></i> <%= request.getAttribute("message") %>
            </div>
            <% } %>
            <% if (request.getAttribute("error") != null) { %>
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle me-2"></i> <%= request.getAttribute("error") %>
            </div>
            <% } %>

            <form action="update_admin.jsp" method="post" id="updateForm">
                <div class="mb-4">
                    <label for="nom" class="form-label">Nom Complet</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="nom" name="nom" value="<%= administrateur.getNom() %>" required>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="email" class="form-label">Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" value="<%= administrateur.getEmail() %>" required>
                    </div>
                </div>
                <div class="mb-4">
                    <label for="motDePasse" class="form-label">Mot de Passe (laisser vide pour ne pas changer)</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="motDePasse" name="motDePasse">
                        <button class="btn btn-outline-secondary" type="button" id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100">
                    <i class="fas fa-save"></i> Mettre à jour
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.querySelector('.sidebar');
    const content = document.querySelector('.content');
    const passwordInput = document.getElementById('motDePasse');
    const togglePassword = document.getElementById('togglePassword');
    let isPasswordVisible = false;

    // Toggle sidebar on mobile
    sidebarToggle.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        content.classList.toggle('shifted');
    });

    document.addEventListener('click', (e) => {
        if (window.innerWidth <= 991 &&
            !sidebar.contains(e.target) &&
            !sidebarToggle.contains(e.target) &&
            sidebar.classList.contains('active')) {
            sidebar.classList.remove('active');
        }
    });

    // Toggle password visibility
    togglePassword.addEventListener('click', () => {
        isPasswordVisible = !isPasswordVisible;
        passwordInput.type = isPasswordVisible ? 'text' : 'password';
        togglePassword.querySelector('i').className = isPasswordVisible ? 'fas fa-eye-slash' : 'fas fa-eye';
    });
</script>
</body>
</html>