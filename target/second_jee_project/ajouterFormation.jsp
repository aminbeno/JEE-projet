<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.time.LocalDate, java.time.format.DateTimeFormatter, java.time.format.DateTimeParseException" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ajout d'une Formation</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: #ffffff;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .result-container {
            max-width: 550px;
            width: 100%;
            margin: 20px;
        }
        .card {
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            background: white;
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        .card-header {
            background: linear-gradient(90deg, #007bff, #0056b3);
            padding: 1.5rem;
            border-bottom: none;
        }
        .card-header h4 {
            margin: 0;
            color: white;
            font-weight: 700;
            font-size: 1.6rem;
        }
        .card-body {
            padding: 2.5rem;
        }
        .success-icon {
            font-size: 4.5rem;
            color: #28a745;
            margin-bottom: 1.5rem;
        }
        .error-icon {
            font-size: 4.5rem;
            color: #dc3545;
            margin-bottom: 1.5rem;
        }
        h2 {
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1rem;
        }
        p {
            color: #495057;
            font-size: 1.2rem;
            line-height: 1.6;
            margin-bottom: 2rem;
        }
        .btn-primary {
            background: linear-gradient(90deg, #007bff, #0062cc);
            border: none;
            padding: 12px 35px;
            border-radius: 25px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
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
        }
    </style>
</head>
<body>
<div class="result-container">
    <div class="card">
        <div class="card-header text-center">
            <h4><i class="fas fa-chalkboard-teacher me-2"></i> Ajout d'une Formation</h4>
        </div>
        <div class="card-body text-center">
            <%
                String nom = request.getParameter("nom");
                String categorie = request.getParameter("categorie");
                String dateStr = request.getParameter("date");
                String nombrePlacesStr = request.getParameter("nombrePlaces");
                String statut = request.getParameter("statut");
                boolean success = false;
                String errorMessage = null;

                try {
                    // Validation des paramètres
                    if (nom == null || nom.trim().isEmpty()) {
                        throw new IllegalArgumentException("Le nom de la formation est requis.");
                    }
                    if (dateStr == null || dateStr.trim().isEmpty()) {
                        throw new IllegalArgumentException("La date est requise.");
                    }
                    if (nombrePlacesStr == null || nombrePlacesStr.trim().isEmpty()) {
                        throw new IllegalArgumentException("Le nombre de places est requis.");
                    }
                    if (statut == null || statut.trim().isEmpty()) {
                        throw new IllegalArgumentException("Le statut est requis.");
                    }

                    // Validation et conversion de la date
                    LocalDate date;
                    try {
                        date = LocalDate.parse(dateStr, DateTimeFormatter.ISO_LOCAL_DATE);
                    } catch (DateTimeParseException e) {
                        throw new IllegalArgumentException("Format de date invalide.");
                    }

                    // Validation et conversion du nombre de places
                    int nombrePlaces;
                    try {
                        nombrePlaces = Integer.parseInt(nombrePlacesStr);
                        if (nombrePlaces <= 0) {
                            throw new IllegalArgumentException("Le nombre de places doit être supérieur à 0.");
                        }
                    } catch (NumberFormatException e) {
                        throw new IllegalArgumentException("Le nombre de places doit être un nombre valide.");
                    }

                    // Connexion à la base de données
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");
                         PreparedStatement stmt = conn.prepareStatement(
                                 "INSERT INTO formation (nom, categorie, date, nombrePlaces, statut) VALUES (?, ?, ?, ?, ?)")) {

                        stmt.setString(1, nom.trim());
                        stmt.setString(2, categorie != null && !categorie.trim().isEmpty() ? categorie.trim() : null);
                        stmt.setDate(3, java.sql.Date.valueOf(date));
                        stmt.setInt(4, nombrePlaces);
                        stmt.setString(5, statut.trim());

                        stmt.executeUpdate();
                        success = true;
                    }
                } catch (Exception e) {
                    errorMessage = "Erreur : " + e.getMessage();
                }

                if (success) {
            %>
            <div class="success-icon"><i class="fas fa-check-circle"></i></div>
            <h2 style="color: #28a745">Formation Ajoutée !</h2>
            <p>La formation "<%= nom %>" a été ajoutée avec succès à la base de données.</p>
            <a href="formation.jsp" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Retour aux formations</a>
            <%
            } else {
            %>
            <div class="error-icon"><i class="fas fa-exclamation-circle"></i></div>
            <h2 style="color: #dc3545">Échec de l'Ajout</h2>
            <p><%= errorMessage != null ? errorMessage : "Une erreur inattendue s'est produite." %></p>
            <a href="formation.jsp" class="btn btn-primary"><i class="fas fa-arrow-left"></i> Retour aux formations</a>
            <%
                }
            %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Redirection automatique après 5 secondes en cas de succès
    <% if (success) { %>
    setTimeout(() => {
        window.location.href = 'formation.jsp';
    }, 5000);
    <% } %>
</script>
</body>
</html>