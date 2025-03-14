package fpt.example.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "joueur")
public class Joueur {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @Column(name = "prenom", nullable = false, length = 100)
    private String prenom;

    @ManyToOne
    @JoinColumn(name = "equipe_id")
    private Equipe equipe;

    public Joueur() {}

    public Joueur(String nom, String prenom, Equipe equipe) {
        this.nom = nom;
        this.prenom = prenom;
        this.equipe = equipe;
    }

    public Long getId() { return id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public String getPrenom() { return prenom; }
    public void setPrenom(String prenom) { this.prenom = prenom; }
    public Equipe getEquipe() { return equipe; }
    public void setEquipe(Equipe equipe) { this.equipe = equipe; }
}
