<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestion des Certificats</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
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
    <h2>Gestion des Certificats</h2>

    <!-- Liste des étudiants avec option de génération de certificat -->
    <div class="card p-4">
        <h4>Liste des Étudiants</h4>
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
                // Utilisation du try-with-resources pour gérer les ressources
                try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");
                     Statement stmt = conn.createStatement();
                     ResultSet rs = stmt.executeQuery("SELECT * FROM etudiant")) {

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
                        <%= interdit ? "Interdit ❌" : "Autorisé ✅" %>
                    </span>
                </td>
                <td>
                    <% if (!interdit) { %>
                    <form action="certificat_generate.jsp" method="post">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" class="btn btn-primary">📜 Générer</button>
                    </form>
                    <% } else { %>
                    <button class="btn btn-secondary" disabled>❌ Interdit</button>
                    <% } %>
                </td>
            </tr>
            <%
                    }
                } catch (SQLException e) {
                    out.println("<tr><td colspan='5' class='text-danger'>Erreur SQL : " + e.getMessage() + "</td></tr>");
                } catch (Exception e) {
                    out.println("<tr><td colspan='5' class='text-danger'>Erreur : " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
