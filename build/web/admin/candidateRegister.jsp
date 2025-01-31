<%@page import="classes.candidate"%>
<%@page import="java.sql.Connection"%>
<%@page import="classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        // Retrieve and trim parameters
        String name = request.getParameter("name").trim();
        String party_name = request.getParameter("party_name").trim();
        String description = request.getParameter("description").trim();
        int election_id = Integer.parseInt(request.getParameter("election_id")); // Get election_id

        // Basic input validation
        if (name == null || name.isEmpty() || 
            party_name == null || party_name.isEmpty() || 
            description == null || description.isEmpty()) {
            response.sendRedirect("addCandidate.jsp?s=3"); // Invalid input data
            return;
        }

        // Create candidate object with election_id
        candidate Candidate = new candidate(name, party_name, description, election_id);

        // Try-with-resources block to ensure connection is closed
        try (Connection con = db_connector.getConnection()) {
            if (Candidate.register(con)) {
                response.sendRedirect("addCandidate.jsp?s=1"); // Success
            } else {
                response.sendRedirect("addCandidate.jsp?s=2"); // Database insertion failed or duplicate
            }
        } catch (Exception e) {
            e.printStackTrace(); // Log exception for debugging
            response.sendRedirect("addCandidate.jsp?s=0"); // Database error
        }

    } catch (Exception e) {
        e.printStackTrace(); // Log general error
        response.sendRedirect("addCandidate.jsp?s=0"); // General error
    }
%>