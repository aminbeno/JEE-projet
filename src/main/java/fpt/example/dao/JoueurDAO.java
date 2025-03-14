package fpt.example.dao;


import jakarta.persistence.*;
import java.util.List;
import fpt.example.entities.Joueur;

public class JoueurDAO {
    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    public void saveJ(Joueur joueur) {
        EntityManager em = emf.createEntityManager();
        EntityTransaction tx = em.getTransaction();
        try {
            tx.begin();
            em.persist(joueur);
            tx.commit();
        } catch (Exception e) {
            if (tx != null && tx.isActive()) {
                tx.rollback();
            }
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public List<Joueur> getAllJ() {
        EntityManager em = emf.createEntityManager();
        List<Joueur> joueurs = em.createQuery("SELECT j FROM Joueur j", Joueur.class).getResultList();
        em.close();
        return joueurs;
    }
}



