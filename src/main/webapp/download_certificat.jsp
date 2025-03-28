<%@ page language="java" contentType="application/pdf" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.sql.*, javax.servlet.*, javax.servlet.http.*" %>
<%@ page import="com.itextpdf.text.*, com.itextpdf.text.pdf.*" %>

<%
    String id = request.getParameter("id");
    if (id != null && !id.isEmpty()) {
        // Connexion à la base de données
        Connection con = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        String nom = null, email = null, formation = null, categorie = null;
        java.sql.Date dateFormation = null;

        try {
            // Connexion à la base de données
            String url = "jdbc:mysql://localhost:3306/votre_database";
            String user = "root";
            String password = "votre_mot_de_passe";
            con = DriverManager.getConnection(url, user, password);

            // Requête SQL
            String sql = "SELECT nom, email, formation, categorie, date_de_formation FROM utilisateurs WHERE id = ?";
            stmt = con.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();

            // Récupération des données
            if (rs.next()) {
                nom = rs.getString("nom");
                email = rs.getString("email");
                formation = rs.getString("formation");
                categorie = rs.getString("categorie");
                dateFormation = rs.getDate("date_de_formation");
            }

            // Création du PDF
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Titre du certificat
            document.add(new Paragraph("Certificat de Formation"));
            document.add(new Paragraph("Nom: " + nom));
            document.add(new Paragraph("Email: " + email));
            document.add(new Paragraph("Formation: " + formation));
            document.add(new Paragraph("Catégorie: " + categorie));
            document.add(new Paragraph("Date de Formation: " + dateFormation));

            // Fermer le document PDF
            document.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Erreur lors de la génération du certificat PDF : " + e.getMessage());
        } finally {
            // Fermeture des ressources
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("ID manquant pour générer le certificat.");
    }
%>
