<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="fpt.example.entities.Formation, jakarta.persistence.*, java.util.*" %>

<html>
<head>
    <title>Inscription</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Inscription à une Formation</h2>

    <form action="InscriptionServlet" method="post" class="mt-4">
        <div class="mb-3">
            <label for="nom" class="form-label">Nom</label>
            <input type="text" class="form-control" id="nom" name="nom" required>
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>

        <div class="mb-3">
            <label for="formation" class="form-label">Choisir une Formation</label>
            <select class="form-control" id="formation" name="formation_id">
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
</body>
</html>
