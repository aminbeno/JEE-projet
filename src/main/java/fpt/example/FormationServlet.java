package fpt.example;



import fpt.example.dao.FormationDAO;
import fpt.example.entities.Formation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/formations")
public class FormationServlet extends HttpServlet {

    private FormationDAO formationDAO = new FormationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Formation> formations = formationDAO.getToutesFormations();
        request.setAttribute("formations", formations);
        request.getRequestDispatcher("formations.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nom = request.getParameter("nom");
        String categorie = request.getParameter("categorie");
        String dateStr = request.getParameter("date");
        int nombrePlaces = Integer.parseInt(request.getParameter("nombrePlaces"));
        String statut = request.getParameter("statut");

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = sdf.parse(dateStr);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        Formation formation = new Formation(nom, categorie, date, nombrePlaces, statut);
        formationDAO.ajouterFormation(formation);

        response.sendRedirect("formations");
    }
}
