<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Déconnexion</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: #ffffff; /* Fond blanc */
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .logout-container {
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
            text-align: center;
        }
        .card-body {
            padding: 2.5rem;
            text-align: center;
        }
        .logout-icon {
            font-size: 4.5rem;
            color: #28a745;
            margin-bottom: 1.5rem;
        }
        h2 {
            font-weight: 700;
            font-size: 2rem;
            margin-bottom: 1rem;
            color: #28a745;
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
            color: white;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #0062cc, #004085);
            transform: translateY(-2px);
            box-shadow: 0 7px 20px rgba(0, 123, 255, 0.3);
        }
        .btn-primary i {
            margin-right: 8px;
        }
    </style>
</head>
<body>
<div class="logout-container">
    <div class="card">
        <div class="card-header">
            <h4><i class="fas fa-sign-out-alt me-2"></i> Déconnexion</h4>
        </div>
        <div class="card-body">
            <%
                // Récupérer la session existante (sans en créer une nouvelle)
                HttpSession sessionActive = request.getSession(false);

                // Vérifier si une session existe, puis l'invalider
                if (sessionActive != null) {
                    sessionActive.invalidate(); // Supprime toutes les données de session
                }
            %>
            <div class="logout-icon"><i class="fas fa-check-circle"></i></div>
            <h2>Déconnexion Réussie</h2>
            <p>Vous avez été déconnecté avec succès. Vous serez redirigé vers la page de connexion dans quelques secondes.</p>
            <a href="AdminLogin.jsp" class="btn btn-primary"><i class="fas fa-sign-in-alt"></i> Retour à la connexion</a>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Redirection automatique après 5 secondes
    setTimeout(() => {
        window.location.href = 'AdminLogin.jsp';
    }, 5000);
</script>
</body>
</html>