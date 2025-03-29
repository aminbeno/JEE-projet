<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fpt.example.entities.Formation, jakarta.persistence.*, java.util.*" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Inscription à une Formation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #f5f6fa 0%, #e9ecef 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .form-container {
            max-width: 550px;
            width: 100%;
            margin: 20px;
        }
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            background: white;
            overflow: hidden;
        }
        .card-header {
            background: linear-gradient(90deg, #007bff, #0056b3);
            padding: 1.5rem;
            border-bottom: none;
        }
        .card-header h2 {
            margin: 0;
            color: white;
            font-weight: 600;
            font-size: 1.6rem;
        }
        .card-body {
            padding: 2.5rem;
        }
        .form-label {
            font-weight: 600;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        .form-control, .form-select {
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #ced4da;
            transition: all 0.3s ease;
        }
        .form-control:focus, .form-select:focus {
            border-color: #007bff;
            box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.2);
        }
        .btn-primary {
            background: linear-gradient(90deg, #007bff, #0062cc);
            border: none;
            padding: 12px;
            border-radius: 10px;
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
    </style>
</head>
<body>
<div class="form-container">
    <div class="card">
        <div class="card-header text-center">
            <h2><i class="fas fa-user-graduate me-2"></i> Inscription Formation</h2>
        </div>
        <div class="card-body">
            <form action="InscriptionServlet" method="post" id="inscriptionForm">
                <div class="mb-4">
                    <label for="nom" class="form-label">Nom Complet</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                        <input type="text"
                               class="form-control"
                               id="nom"
                               name="nom"
                               required
                               placeholder="Jean Dupont">
                    </div>
                </div>

                <div class="mb-4">
                    <label for="email" class="form-label">Adresse Email</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="email"
                               required
                               placeholder="jean.dupont@email.com">
                    </div>
                </div>

                <div class="mb-4">
                    <label for="formation" class="form-label">Choisir une Formation</label>
                    <div class="input-group">
                        <span class="input-group-text"><i class="fas fa-book"></i></span>
                        <select class="form-select"
                                id="formation"
                                name="formation_id"
                                required>
                            <option value="" disabled selected>Sélectionnez une formation</option>
                            <%
                                EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");
                                EntityManager em = emf.createEntityManager();
                                List<Formation> formations = em.createQuery("SELECT f FROM Formation f", Formation.class).getResultList();
                                em.close();
                                for (Formation f : formations) {
                            %>
                            <option value="<%= f.getId() %>"><%= f.getNom() %></option>
                            <%
                                }
                            %>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn btn-primary w-100" id="submitBtn">
                    S'inscrire
                    <span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span>
                </button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.getElementById('inscriptionForm').addEventListener('submit', function(e) {
        const submitBtn = document.getElementById('submitBtn');
        const spinner = submitBtn.querySelector('.spinner-border');

        submitBtn.disabled = true;
        spinner.style.display = 'inline-block';
    });

    // Validation basique côté client
    const emailInput = document.getElementById('email');
    emailInput.addEventListener('input', function() {
        if (!this.checkValidity()) {
            this.classList.add('is-invalid');
        } else {
            this.classList.remove('is-invalid');
        }
    });
</script>
</body>
</html>