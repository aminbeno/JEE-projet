<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Gestion des Formations</title>
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
    .form-label {
      font-weight: 600;
      color: #2c3e50;
    }
    .form-control, .form-select {
      border-radius: 10px;
      padding: 12px;
      transition: all 0.3s ease;
    }
    .form-control:focus, .form-select:focus {
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
    .btn-info {
      background: linear-gradient(90deg, #17a2b8, #117a8b);
      border: none;
      padding: 8px 20px;
      border-radius: 25px;
      font-weight: 600;
      transition: all 0.3s ease;
    }
    .btn-info:hover {
      background: linear-gradient(90deg, #117a8b, #0c5460);
      transform: translateY(-2px);
      box-shadow: 0 5px 15px rgba(23, 162, 184, 0.3);
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
  <a href="formation.jsp" class="nav-link active">
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
  <h2 class="mb-4">Gestion des Formations</h2>

  <!-- Formulaire d'ajout d'une formation -->
  <div class="card">
    <div class="card-header">
      <h4><i class="fas fa-plus me-2"></i> Ajouter une Formation</h4>
    </div>
    <div class="card-body">
      <form action="ajouterFormation.jsp" method="post">
        <div class="mb-3">
          <label for="nom" class="form-label">Nom de la Formation</label>
          <input type="text" class="form-control" id="nom" name="nom" required placeholder="Ex: Java Avancé">
        </div>
        <div class="mb-3">
          <label for="categorie" class="form-label">Catégorie</label>
          <input type="text" class="form-control" id="categorie" name="categorie" placeholder="Ex: Programmation">
        </div>
        <div class="mb-3">
          <label for="date" class="form-label">Date</label>
          <input type="date" class="form-control" id="date" name="date" required>
        </div>
        <div class="mb-3">
          <label for="nombrePlaces" class="form-label">Nombre de Places</label>
          <input type="number" class="form-control" id="nombrePlaces" name="nombrePlaces" required min="1" placeholder="Ex: 20">
        </div>
        <div class="mb-4">
          <label for="statut" class="form-label">Statut</label>
          <select class="form-select" id="statut" name="statut" required>
            <option value="Ouvert">Ouvert</option>
            <option value="Fermé">Fermé</option>
          </select>
        </div>
        <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i> Ajouter</button>
      </form>
    </div>
  </div>

  <!-- Liste des formations -->
  <div class="card">
    <div class="card-header">
      <h4><i class="fas fa-list me-2"></i> Liste des Formations</h4>
    </div>
    <div class="card-body">
      <div class="table-responsive">
        <table class="table table-striped">
          <thead>
          <tr>
            <th>ID</th>
            <th>Nom</th>
            <th>Catégorie</th>
            <th>Date</th>
            <th>Places</th>
            <th>Statut</th>
            <th>Étudiants</th>
          </tr>
          </thead>
          <tbody>
          <%
            try {
              Class.forName("com.mysql.cj.jdbc.Driver");
              Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");
              Statement stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery("SELECT * FROM formation");

              while (rs.next()) {
          %>
          <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("nom") %></td>
            <td><%= rs.getString("categorie") != null ? rs.getString("categorie") : "N/A" %></td>
            <td><%= rs.getDate("date") %></td>
            <td><%= rs.getInt("nombrePlaces") %></td>
            <td>
                                <span class="badge <%= rs.getString("statut").equals("Ouvert") ? "bg-success" : "bg-danger" %>">
                                    <%= rs.getString("statut") %>
                                </span>
            </td>
            <td>
              <a href="etudiant.jsp?formation_id=<%= rs.getInt("id") %>" class="btn btn-info btn-sm">
                <i class="fas fa-eye me-1"></i> Voir
              </a>
            </td>
          </tr>
          <%
              }
              rs.close();
              stmt.close();
              conn.close();
            } catch (Exception e) {
              out.println("<tr><td colspan='7' class='text-danger'>Erreur : " + e.getMessage() + "</td></tr>");
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