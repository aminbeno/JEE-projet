package fpt.example;

import fpt.example.dao.AdministrateurDAO;
import fpt.example.entities.Administrateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/RegisterAdminServlet") // L'URL de votre servlet
public class RegisterAdminServlet extends HttpServlet {

    private AdministrateurDAO administrateurDAO = new AdministrateurDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer les données du formulaire
        String nom = request.getParameter("nom");
        String email = request.getParameter("email");
        String motDePasse = request.getParameter("password");

        // Vérification des données
        if (nom == null || email == null || motDePasse == null || email.isEmpty() || motDePasse.isEmpty() || nom.isEmpty()) {
            request.setAttribute("error", "Tous les champs sont obligatoires !");
            request.getRequestDispatcher("/register-admin.jsp").forward(request, response);
            return;
        }

        // Vérifier si l'email existe déjà
        Administrateur existingAdmin = administrateurDAO.getAdministrateurParEmail(email);
        if (existingAdmin != null) {
            // Si l'email existe déjà, rediriger avec un message d'erreur
            request.setAttribute("error", "Cet email est déjà utilisé !");
            request.getRequestDispatcher("/register-admin.jsp").forward(request, response);
            return;
        }

        // Créer un nouvel administrateur
        Administrateur administrateur = new Administrateur(nom, email, motDePasse);

        // Enregistrer l'administrateur avec un mot de passe sécurisé
        administrateurDAO.inscrireAdministrateur(administrateur);

        // Rediriger vers la page de connexion avec un message de succès
        response.sendRedirect("AdminLogin.jsp");
    }
}
