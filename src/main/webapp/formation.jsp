<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Gestion des Formations</title>

  <!-- Bootstrap -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

  <style>
    /* Sidebar styling */
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
  <h2>Gestion des Formations</h2>

  <!-- Formulaire d'ajout d'une formation -->
  <div class="card p-4 mb-4">
    <h4>Ajouter une nouvelle formation</h4>
    <form action="ajouterFormation.jsp" method="post">
      <div class="mb-3">
        <label for="nom" class="form-label">Nom de la formation</label>
        <input type="text" class="form-control" id="nom" name="nom" required>
      </div>
      <div class="mb-3">
        <label for="categorie" class="form-label">Catégorie</label>
        <input type="text" class="form-control" id="categorie" name="categorie">
      </div>
      <div class="mb-3">
        <label for="date" class="form-label">Date</label>
        <input type="date" class="form-control" id="date" name="date" required>
      </div>
      <div class="mb-3">
        <label for="nombrePlaces" class="form-label">Nombre de places</label>
        <input type="number" class="form-control" id="nombrePlaces" name="nombrePlaces" required>
      </div>
      <div class="mb-3">
        <label for="statut" class="form-label">Statut</label>
        <select class="form-control" id="statut" name="statut" required>
          <option value="Ouvert">Ouvert</option>
          <option value="Fermé">Fermé</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary">Ajouter</button>
    </form>
  </div>

  <!-- Liste des formations -->
  <div class="card p-4">
    <h4>Liste des formations</h4>
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
        <td><%= rs.getString("categorie") %></td>
        <td><%= rs.getDate("date") %></td>
        <td><%= rs.getInt("nombrePlaces") %></td>
        <td><%= rs.getString("statut") %></td>
        <td>
          <a href="etudiant.jsp?formation_id=<%= rs.getInt("id") %>" class="btn btn-info btn-sm">Voir</a>
        </td>
      </tr>
      <%
          }
          rs.close();
          stmt.close();
          conn.close();
        } catch (Exception e) {
          out.println("<tr><td colspan='7'>Erreur : " + e.getMessage() + "</td></tr>");
        }
      %>
      </tbody>
    </table>
  </div>
</div>

</body>
</html>
