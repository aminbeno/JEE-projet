package fpt.example;

import fpt.example.dao.JoueurDAO;
import fpt.example.dao.EquipeDAO;
import fpt.example.entities.Joueur;
import fpt.example.entities.Equipe;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/joueurServ")
public class JoueurServlet extends HttpServlet {
    private JoueurDAO joueurDAO = new JoueurDAO();
    private EquipeDAO equipeDAO = new EquipeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Joueur> joueurs = joueurDAO.getAllJ();
        List<Equipe> equipes = equipeDAO.getAll();
        request.setAttribute("joueurs", joueurs);
        request.setAttribute("equipes", equipes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("joueurs.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        Long equipeId = Long.parseLong(request.getParameter("equipe"));

        Equipe equipe = equipeDAO.getAll().stream().filter(e -> e.getId().equals(equipeId)).findFirst().orElse(null);
        if (equipe != null) {
            Joueur joueur = new Joueur(nom, prenom, equipe);
            joueurDAO.saveJ(joueur);
        }

        response.sendRedirect("joueurServ");
    }
}

