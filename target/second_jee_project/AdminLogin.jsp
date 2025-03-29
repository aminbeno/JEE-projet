<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Connexion Administrateur</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
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
        .login-container {
            max-width: 550px;
            width: 100%;
            margin: 20px;
        }
        .login-card {
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
            background: white;
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
            position: relative;
        }
        .card-header {
            background: linear-gradient(90deg, #007bff, #0056b3);
            padding: 1.8rem;
            border-bottom: none;
        }
        .card-header h4 {
            margin: 0;
            color: white;
            font-weight: 700;
            font-size: 1.6rem;
        }
        .card-body {
            padding: 3rem;
        }
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        .form-control {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ced4da;
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
            margin-bottom: 2rem;
            padding: 1rem;
            font-weight: 500;
            background: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
        }
        .link-register {
            color: #495057;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        .link-register:hover {
            color: #007bff;
        }
        .input-group-text {
            border-radius: 10px;
            background: #f8f9fa;
            border: 1px solid #ced4da;
        }
        .spinner-border {
            display: none;
            width: 1rem;
            height: 1rem;
            vertical-align: text-bottom;
            margin-left: 10px;
        }
        .input-icon {
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="login-container">
    <div class="login-card">
        <div class="card-header text-center">
            <h4><i class="fas fa-user-lock me-2"></i> Connexion Admin</h4>
        </div>
        <div class="card-body">
            <% String errorMessage = request.getParameter("error"); %>
            <% if (errorMessage != null) { %>
            <div class="alert alert-danger text-center" role="alert">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <%= errorMessage.equals("true") ? "Email ou mot de passe incorrect !" : errorMessage %>
            </div>
            <% } %>

            <form action="LoginServlet" method="post" id="loginForm">
                <div class="mb-4">
                    <label class="form-label">Adresse Email</label>
                    <div class="input-group input-icon">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email"
                               name="email"
                               class="form-control"
                               placeholder="admin@entreprise.com"
                               required
                               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
                    </div>
                </div>
                <div class="mb-4">
                    <label class="form-label">Mot de passe</label>
                    <div class="input-group input-icon">
                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                        <input type="password"
                               name="password"
                               id="password"
                               class="form-control"
                               placeholder="••••••••"
                               required>
                        <button class="btn btn-outline-secondary"
                                type="button"
                                id="togglePassword">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                <button type="submit" class="btn btn-primary w-100" id="submitBtn">
                    <i class="fas fa-sign-in-alt"></i> Se connecter
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                </button>
            </form>

            <div class="text-center mt-4">
                <a href="register-admin.jsp" class="link-register">
                    <i class="fas fa-user-plus me-1"></i> Créer un compte admin
                </a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    const passwordInput = document.getElementById('password');
    const togglePassword = document.getElementById('togglePassword');
    const submitBtn = document.getElementById('submitBtn');
    const spinner = submitBtn.querySelector('.spinner-border');
    let isPasswordVisible = false;

    // Toggle password visibility
    togglePassword.addEventListener('click', () => {
        isPasswordVisible = !isPasswordVisible;
        passwordInput.type = isPasswordVisible ? 'text' : 'password';
        togglePassword.querySelector('i').className = isPasswordVisible ? 'fas fa-eye-slash' : 'fas fa-eye';
    });

    // Show loading spinner on form submit
    document.getElementById('loginForm').addEventListener('submit', function(e) {
        submitBtn.disabled = true;
        spinner.style.display = 'inline-block';
    });
</script>
</body>
</html>