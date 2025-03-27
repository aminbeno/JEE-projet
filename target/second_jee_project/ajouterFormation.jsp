<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>

<%
    String nom = request.getParameter("nom");
    String categorie = request.getParameter("categorie");
    String date = request.getParameter("date");
    int nombrePlaces = Integer.parseInt(request.getParameter("nombrePlaces"));
    String statut = request.getParameter("statut");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");

        String sql = "INSERT INTO formation (nom, categorie, date, nombrePlaces, statut) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, nom);
        stmt.setString(2, categorie);
        stmt.setString(3, date);
        stmt.setInt(4, nombrePlaces);
        stmt.setString(5, statut);

        stmt.executeUpdate();
        stmt.close();
        conn.close();

        response.sendRedirect("formation.jsp"); // Redirige vers la page des formations
    } catch (Exception e) {
        out.println("Erreur : " + e.getMessage());
    }
%>
