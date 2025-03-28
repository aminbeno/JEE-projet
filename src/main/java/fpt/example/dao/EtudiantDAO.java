package fpt.example.dao;

import fpt.example.entities.Etudiant;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

public class EtudiantDAO {
    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    public void ajouterEtudiant(Etudiant etudiant) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(etudiant);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}

