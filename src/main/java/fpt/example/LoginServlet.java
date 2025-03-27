package fpt.example;

import fpt.example.dao.AdministrateurDAO;
import fpt.example.entities.Administrateur;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirige vers la page de connexion
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Utilisation de la méthode correcte du DAO pour vérifier les informations de connexion
        AdministrateurDAO adminDAO = new AdministrateurDAO();
        Administrateur admin = adminDAO.verifierLogin(email, password);

        // Vérifier si l'admin existe
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("administrateur", admin); // Enregistrer l'administrateur dans la session
            response.sendRedirect("dashboard.jsp"); // Redirection vers le tableau de bord après connexion
        } else {
            // Rediriger avec un message d'erreur si l'authentification échoue
            response.sendRedirect("login.jsp?error=true&email=" + email);
        }
    }
}
