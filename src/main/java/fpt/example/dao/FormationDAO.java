package fpt.example.dao;

import fpt.example.entities.Formation;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class FormationDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("my_persistence_unit");

    public void ajouterFormation(Formation formation) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        em.persist(formation);
        em.getTransaction().commit();
        em.close();
    }

    public List<Formation> getToutesFormations() {
        EntityManager em = emf.createEntityManager();
        List<Formation> formations = em.createQuery("SELECT f FROM Formation f", Formation.class).getResultList();
        em.close();
        return formations;
    }

    public Formation getFormationById(int id) {
        EntityManager em = emf.createEntityManager();
        Formation formation = em.find(Formation.class, id);
        em.close();
        return formation;
    }

    public void supprimerFormation(int id) {
        EntityManager em = emf.createEntityManager();
        em.getTransaction().begin();
        Formation formation = em.find(Formation.class, id);
        if (formation != null) {
            em.remove(formation);
        }
        em.getTransaction().commit();
        em.close();
    }
}
