<%@page import="java.sql.*, classes.db_connector"%>
<%
    String candidateIdStr = request.getParameter("candidate_id");

    // Validate candidate_id parameter
    if (candidateIdStr == null || candidateIdStr.isEmpty()) {
        out.println("Error: No candidate ID provided.");
        return;
    }

    int candidateId = 0;
    try {
        candidateId = Integer.parseInt(candidateIdStr);
    } catch (NumberFormatException e) {
        out.println("Error: Invalid candidate ID format.");
        return;
    }

    Connection con = null;
    PreparedStatement ps = null;
    try {
        con = db_connector.getConnection();
        
        // Delete candidate by candidate_id
        String deleteQuery = "DELETE FROM candidates WHERE candidate_id = ?";
        ps = con.prepareStatement(deleteQuery);
        ps.setInt(1, candidateId);

        int rowsDeleted = ps.executeUpdate();
        if (rowsDeleted > 0) {
            out.println("Candidate deleted successfully.");
        } else {
            out.println("Error: Could not delete candidate. Candidate not found.");
        }
    } catch (SQLException e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        try {
            if (ps != null) ps.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
