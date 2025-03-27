<%@ page import="java.sql.*" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");

        // Récupérer l'état actuel
        PreparedStatement selectStmt = conn.prepareStatement("SELECT certificat_interdit FROM etudiant WHERE id = ?");
        selectStmt.setInt(1, id);
        ResultSet rs = selectStmt.executeQuery();
        boolean actuel = false;
        if (rs.next()) {
            actuel = rs.getBoolean("certificat_interdit");
        }
        rs.close();
        selectStmt.close();

        // Mettre à jour l'état (inverser)
        PreparedStatement updateStmt = conn.prepareStatement("UPDATE etudiant SET certificat_interdit = ? WHERE id = ?");
        updateStmt.setBoolean(1, !actuel);
        updateStmt.setInt(2, id);
        updateStmt.executeUpdate();
        updateStmt.close();
        conn.close();

        // Redirection vers la liste des étudiants
        response.sendRedirect("etudiant.jsp");
    } catch (Exception e) {
        out.println("Erreur : " + e.getMessage());
    }
%>
