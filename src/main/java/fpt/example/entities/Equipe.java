package fpt.example.entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "equipe")
public class Equipe {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "nom", nullable = false, length = 100)
    private String nom;

    @OneToMany(mappedBy = "equipe", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Joueur> joueurs;

    public Equipe() {}

    public Equipe(String nom) {
        this.nom = nom;
    }

    public Long getId() { return id; }
    public String getNom() { return nom; }
    public void setNom(String nom) { this.nom = nom; }
    public List<Joueur> getJoueurs() { return joueurs; }
    public void setJoueurs(List<Joueur> joueurs) { this.joueurs = joueurs; }
}
