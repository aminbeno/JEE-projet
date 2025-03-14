package fpt.example.dao;

import fpt.example.entities.Equipe;
import jakarta.persistence.*;
import java.util.List;

public class EquipeDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    public void save(Equipe equipe) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();

        try {
            tx.begin();
            em.persist(equipe);
            tx.commit();
            System.out.println("✅ Équipe ajoutée : " + equipe.getNom());
        } catch (Exception e) {
            if (tx.isActive()) tx.rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Equipe> getAll() {
        EntityManager em = emf.createEntityManager();
        List<Equipe> equipes = em.createQuery("SELECT e FROM Equipe e", Equipe.class).getResultList();
        em.close();
        return equipes;
    }
}

