<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Succès de l'Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #e9f7f2 0%, #d4e8f5 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .success-container {
            max-width: 550px;
            width: 100%;
            margin: 20px;
            background: white;
            border-radius: 20px;
            padding: 3rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
        }
        .success-icon {
            font-size: 4.5rem;
            color: #28a745;
            margin-bottom: 1.5rem;
            animation: bounceIn 0.8s ease-out;
        }
        h2 {
            color: #28a745;
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
        @keyframes bounceIn {
            0% { transform: scale(0); opacity: 0; }
            60% { transform: scale(1.1); opacity: 1; }
            100% { transform: scale(1); }
        }
        .confetti {
            position: absolute;
            width: 10px;
            height: 10px;
            background: #28a745;
            opacity: 0.7;
            animation: fall 3s infinite;
        }
        @keyframes fall {
            0% { transform: translateY(-100px) rotate(0deg); opacity: 0.7; }
            100% { transform: translateY(100vh) rotate(360deg); opacity: 0; }
        }
    </style>
</head>
<body>
<div class="success-container text-center">
    <div class="success-icon"><i class="fas fa-check-circle"></i></div>
    <h2>Inscription Réussie !</h2>
    <p>Merci pour votre inscription. Une confirmation vous sera envoyée par email dans les plus brefs délais.</p>
    <a href="inscription.jsp" class="btn btn-primary">
        <i class="fas fa-home"></i> Retour à l'accueil
    </a>
    <!-- Confettis décoratifs -->
    <div class="confetti" style="left: 20%; top: 0; animation-delay: 0s;"></div>
    <div class="confetti" style="left: 40%; top: 0; animation-delay: 0.5s; background: #007bff;"></div>
    <div class="confetti" style="left: 60%; top: 0; animation-delay: 1s;"></div>
    <div class="confetti" style="left: 80%; top: 0; animation-delay: 1.5s; background: #007bff;"></div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Optionnel : Redirection automatique après 5 secondes
    setTimeout(() => {
        window.location.href = 'inscription.jsp';
    }, 5000);
</script>
</body>
</html>