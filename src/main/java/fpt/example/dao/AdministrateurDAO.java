package fpt.example.dao;

import fpt.example.entities.Administrateur;
import jakarta.persistence.*;

public class AdministrateurDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    // Vérifier les informations de connexion
    public Administrateur verifierLogin(String email, String motDePasse) {
        EntityManager em = emf.createEntityManager();
        Administrateur admin = null;
        try {
            TypedQuery<Administrateur> query = em.createQuery(
                    "SELECT a FROM Administrateur a WHERE a.email = :email AND a.motDePasse = :motDePasse", Administrateur.class);
            query.setParameter("email", email);
            query.setParameter("motDePasse", motDePasse);

            admin = query.getSingleResult(); // Récupérer l'administrateur
        } catch (NoResultException e) {
            admin = null; // Aucun administrateur trouvé
        } finally {
            em.close();
        }
        return admin;
    }
    public void update(Administrateur admin) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(admin); // Utiliser merge pour mettre à jour l'entité
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
