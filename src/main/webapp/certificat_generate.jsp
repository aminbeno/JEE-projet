<%@ page import="java.sql.*" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDDocument" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDPage" %>
<%@ page import="org.apache.pdfbox.pdmodel.PDPageContentStream" %>
<%@ page import="org.apache.pdfbox.pdmodel.font.PDType1Font" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nom = "", email = "", formationNom = "", formationCategorie = "", formationDate = "", inscriptionDate = "";

    try {
        // Connexion à la base de données
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/jee_db", "root", "");

        // Récupération des informations de l'étudiant
        PreparedStatement stmt = conn.prepareStatement("SELECT e.nom, e.email, f.nom AS formation_nom, f.categorie, f.date AS formation_date  FROM etudiant e INNER JOIN inscription i ON e.id = i.etudiant_id INNER JOIN formation f ON i.formation_id = f.id WHERE e.id = ?");
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            nom = rs.getString("nom");
            email = rs.getString("email");
            formationNom = rs.getString("formation_nom");
            formationCategorie = rs.getString("categorie");
            formationDate = rs.getDate("formation_date").toString();
            inscriptionDate = rs.getDate("inscription_date").toString();
        }

        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        out.println("Erreur : " + e.getMessage());
        return;
    }

    // Création du certificat en PDF
    response.setContentType("application/pdf");
    response.setHeader("Content-Disposition", "attachment; filename=certificat_" + id + ".pdf");

    // Création d'un document PDF avec Apache PDFBox
    PDDocument document = new PDDocument();
    PDPage pdfPage = new PDPage();  // Renommé ici
    document.addPage(pdfPage);

    // Création d'un contenu de page
    PDPageContentStream contentStream = new PDPageContentStream(document, pdfPage);

    // Police d'écriture
    contentStream.setFont(PDType1Font.HELVETICA_BOLD, 18);
    contentStream.beginText();
    contentStream.newLineAtOffset(200, 750);
    contentStream.showText("CERTIFICAT DE FORMATION");
    contentStream.endText();

    // Ajout du contenu
    contentStream.setFont(PDType1Font.HELVETICA, 12);
    contentStream.beginText();
    contentStream.newLineAtOffset(100, 700);
    contentStream.showText("Nom de l'étudiant: " + nom);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Email: " + email);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Formation: " + formationNom);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Catégorie: " + formationCategorie);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Date de formation: " + formationDate);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Date d'inscription: " + inscriptionDate);
    contentStream.newLineAtOffset(0, -20);
    contentStream.showText("Date d'émission: " + new java.util.Date());
    contentStream.endText();

    // Fermeture du contenu
    contentStream.close();

    // Envoi du document en réponse
    document.save(response.getOutputStream());
    document.close();
%>