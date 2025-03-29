<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Succès</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .success-container {
            background: white;
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            margin: 0 auto;
        }
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 1rem;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 10px 30px;
            border-radius: 25px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 123, 255, 0.4);
        }
        h2 {
            color: #28a745;
            font-weight: 600;
        }
        p {
            color: #6c757d;
            font-size: 1.1rem;
        }
    </style>
</head>
<body>
<div class="success-container text-center">
    <div class="success-icon">✓</div>
    <h2>Inscription réussie !</h2>
    <p>Merci pour votre inscription. Vous recevrez bientôt une confirmation par email.</p>
    <a href="inscription.jsp" class="btn btn-primary mt-4">Retour à l'accueil</a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>