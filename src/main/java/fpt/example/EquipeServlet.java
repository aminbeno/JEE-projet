package fpt.example;

import fpt.example.dao.EquipeDAO;
import fpt.example.entities.Equipe;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/equipeServ")
public class EquipeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private EquipeDAO equipeDAO = new EquipeDAO();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Equipe> equipes = equipeDAO.getAll();
        request.setAttribute("equipes", equipes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("equipes.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");

        if (nom != null && !nom.isEmpty()) {
            Equipe equipe = new Equipe(nom);
            equipeDAO.save(equipe);
        }

        response.sendRedirect("equipeServ");
    }
}
