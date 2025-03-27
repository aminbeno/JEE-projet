<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Gestion des Étudiants</title>

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
    <h2>Gestion des Étudiants</h2>

    <%
        // Récupération de l'ID de la formation depuis l'URL
        String formationId = request.getParameter("formation_id");
        if (formationId == null) {
            out.println("<p class='text-danger'>Aucune formation sélectionnée.</p>");
            return;
        }
    %>

    <!-- Liste des étudiants -->
    <div class="card p-4">
        <h4>Liste des Étudiants de la Formation ID: <%= formationId %></h4>
        <table class="table table-striped">
            <thead>
            <tr>
                <th>ID</th>
                <th>Nom</th>
                <th>Email</th>
                <th>Interdiction de Certificat</th>
            </tr>
            </thead>
            <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");

                    // Requête SQL pour récupérer les étudiants de la formation spécifique
                    String sql = "SELECT * FROM etudiant WHERE formation_id = ?";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(formationId));
                    ResultSet rs = pstmt.executeQuery();

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
                    <form action="modifierInterdiction.jsp" method="post">
                        <input type="hidden" name="id" value="<%= id %>">
                        <button type="submit" class="btn <%= interdit ? "btn-danger" : "btn-success" %>">
                            <%= interdit ? "Interdit ❌" : "Autorisé ✅" %>
                        </button>
                    </form>
                </td>
            </tr>
            <%
                    }
                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='4'>Erreur : " + e.getMessage() + "</td></tr>");
                }
            %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
