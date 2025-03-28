package fpt.example.entities;


import jakarta.persistence.*;

@Entity
@Table(name = "etudiant")
public class Etudiant {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    private String nom;
    private String email;

    @ManyToOne
    @JoinColumn(name = "formation_id", nullable = false)
    private Formation formation;

    // Constructeurs
    public Etudiant() {}

    public Etudiant(String nom, String email, Formation formation) {
        this.nom = nom;
        this.email = email;
        this.formation = formation;
    }

    // Getters et Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Formation getFormation() { return formation; }
    public void setFormation(Formation formation) { this.formation = formation; }
}
