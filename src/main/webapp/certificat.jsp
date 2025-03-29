<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestion des Certificats</title>
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
            margin-bottom: 2rem;
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
        }
        .card-body {
            padding: 2.5rem;
        }
        .table {
            border-radius: 10px;
            overflow: hidden;
        }
        .table thead {
            background: #f8f9fa;
        }
        .table th {
            font-weight: 600;
            color: #2c3e50;
        }
        .btn-generate {
            background: linear-gradient(90deg, #007bff, #0062cc);
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            color: white;
        }
        .btn-generate:hover {
            background: linear-gradient(90deg, #0062cc, #004085);
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.3);
        }
        .btn-disabled {
            background: linear-gradient(90deg, #6c757d, #5a6268);
            border: none;
            padding: 8px 20px;
            border-radius: 25px;
            font-weight: 600;
            color: white;
            cursor: not-allowed;
        }
        .badge {
            padding: 6px 12px;
            border-radius: 25px;
            font-weight: 600;
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
    <a href="certificat.jsp" class="nav-link active">
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
    <h2 class="mb-4">Gestion des Certificats</h2>

    <!-- Liste des étudiants -->
    <div class="card">
        <div class="card-header">
            <h4><i class="fas fa-certificate me-2"></i> Liste des Étudiants</h4>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nom</th>
                        <th>Email</th>
                        <th>Statut</th>
                        <th>Action</th>
                    </tr>
                    </thead>
                    <tbody>
                    <%
                        try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");
                             Statement stmt = conn.createStatement();
                             ResultSet rs = stmt.executeQuery("SELECT * FROM etudiant")) {

                            if (!rs.isBeforeFirst()) { // Vérifie si le résultat est vide
                    %>
                    <tr>
                        <td colspan="5" class="text-center text-muted">Aucun étudiant inscrit pour le moment.</td>
                    </tr>
                    <%
                    } else {
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String nom = rs.getString("nom");
                            String email = rs.getString("email");
                            boolean interdit = rs.getBoolean("certificat_interdit");
                    %>
                    <tr>
                        <td><%= id %></td>
                        <td><%= nom %></td>
                        <td><%= email %></td>
                        <td>
                                    <span class="badge <%= interdit ? "bg-danger" : "bg-success" %>">
                                        <i class="fas <%= interdit ? "fa-ban" : "fa-check" %> me-1"></i>
                                        <%= interdit ? "Interdit" : "Autorisé" %>
                                    </span>
                        </td>
                        <td>
                            <% if (!interdit) { %>
                            <form action="certificat_generate.jsp" method="post" class="d-inline">
                                <input type="hidden" name="id" value="<%= id %>">
                                <button type="submit" class="btn btn-generate">
                                    <i class="fas fa-file-download me-1"></i> Générer
                                </button>
                            </form>
                            <% } else { %>
                            <button class="btn btn-disabled" disabled>
                                <i class="fas fa-ban me-1"></i> Interdit
                            </button>
                            <% } %>
                        </td>
                    </tr>
                    <%
                            }
                        }
                    } catch (SQLException e) {
                    %>
                    <tr>
                        <td colspan="5" class="text-danger text-center">
                            <i class="fas fa-exclamation-circle me-2"></i> Erreur SQL : <%= e.getMessage() %>
                        </td>
                    </tr>
                    <%
                    } catch (Exception e) {
                    %>
                    <tr>
                        <td colspan="5" class="text-danger text-center">
                            <i class="fas fa-exclamation-circle me-2"></i> Erreur : <%= e.getMessage() %>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>
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