<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fpt.example.entities.Formation, jakarta.persistence.*, java.util.*" %>

<html>
<head>
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: 500;
            color: #495057;
        }
        .btn-primary {
            background-color: #007bff;
            border: none;
            padding: 12px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn-primary:hover {
            background-color: #0056b3;
            transform: translateY(-2px);
        }
        .form-control {
            border-radius: 8px;
            padding: 10px;
        }
        .form-container {
            max-width: 500px;
        }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="form-container mx-auto">
        <div class="card p-4">
            <h2 class="text-center mb-4">Inscription à une Formation</h2>
            <form action="InscriptionServlet" method="post">
                <div class="mb-3">
                    <label for="nom" class="form-label">Nom</label>
                    <input type="text" class="form-control" id="nom" name="nom" required
                           placeholder="Entrez votre nom">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" required
                           placeholder="votre@email.com">
                </div>

                <div class="mb-4">
                    <label for="formation" class="form-label">Choisir une Formation</label>
                    <select class="form-control" id="formation" name="formation_id">
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

                <button type="submit" class="btn btn-primary w-100">S'inscrire</button>
            </form>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>