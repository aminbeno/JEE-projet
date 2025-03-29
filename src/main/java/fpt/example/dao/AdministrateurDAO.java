package fpt.example.dao;


import fpt.example.entities.Administrateur;
import jakarta.persistence.*;
import org.mindrot.jbcrypt.BCrypt;

public class AdministrateurDAO {

    private EntityManagerFactory emf = Persistence.createEntityManagerFactory("myPU");

    public Administrateur verifierLogin(String email, String motDePasse) {
        EntityManager em = emf.createEntityManager();
        Administrateur admin = null;
        try {
            TypedQuery<Administrateur> query = em.createQuery(
                    "SELECT a FROM Administrateur a WHERE a.email = :email", Administrateur.class);
            query.setParameter("email", email);

            admin = query.getSingleResult(); // Récupérer l'administrateur

            // Vérifier le mot de passe haché
            if (admin != null && BCrypt.checkpw(motDePasse, admin.getMotDePasse())) {
                return admin; // Connexion réussie
            }
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

    public void ajouterAdministrateur(Administrateur admin) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            // Hachage du mot de passe avant d'enregistrer
            String hashedPassword = BCrypt.hashpw(admin.getMotDePasse(), BCrypt.gensalt());
            admin.setMotDePasse(hashedPassword);
            em.persist(admin); // Persister l'entité administrateur
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public void inscrireAdministrateur(Administrateur admin) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            // Hachage du mot de passe avant d'enregistrer
            String hashedPassword = BCrypt.hashpw(admin.getMotDePasse(), BCrypt.gensalt());
            admin.setMotDePasse(hashedPassword); // Enregistrer le mot de passe haché
            em.persist(admin); // Persister l'entité administrateur
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    public Administrateur getAdministrateurParEmail(String email) {
        EntityManager em = emf.createEntityManager();
        try {
            TypedQuery<Administrateur> query = em.createQuery(
                    "SELECT a FROM Administrateur a WHERE a.email = :email", Administrateur.class);
            query.setParameter("email", email);

            // Si l'email existe, retourner l'administrateur
            return query.getSingleResult();
        } catch (NoResultException e) {
            // Aucun administrateur trouvé, retourner null
            return null;
        } finally {
            em.close();
        }
    }

}
