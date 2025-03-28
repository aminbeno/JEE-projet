package fpt.example;


import fpt.example.dao.EtudiantDAO;
import fpt.example.entities.Etudiant;
import fpt.example.entities.Formation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/InscriptionServlet")

public class InscriptionServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        int formationId = Integer.parseInt(request.getParameter("formation_id"));

        EntityManager em = emf.createEntityManager();
        Formation formation = em.find(Formation.class, formationId);

        if (formation != null) {
            Etudiant etudiant = new Etudiant(nom, email, formation);
            new EtudiantDAO().ajouterEtudiant(etudiant);
            response.sendRedirect("success.jsp"); // Redirige vers la page de succès
        } else {
            response.getWriter().println("Erreur : Formation non trouvée.");
        }

        em.close();
    }
}
