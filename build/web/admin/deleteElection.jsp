<%@page import="java.sql.*, classes.db_connector"%>
<%
    String electionIdStr = request.getParameter("election_id");
    if (electionIdStr != null && !electionIdStr.isEmpty()) {
        int electionId = Integer.parseInt(electionIdStr);
        
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = db_connector.getConnection();
            
            // Delete election by election_id
            String deleteQuery = "DELETE FROM elections WHERE election_id = ?";
            ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, electionId);

            int rowsDeleted = ps.executeUpdate();
            if (rowsDeleted > 0) {
                out.println("Election deleted successfully.");
            } else {
                out.println("Error: Could not delete election.");
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
    }
%>
