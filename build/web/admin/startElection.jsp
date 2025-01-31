<%@page import="java.sql.*, classes.db_connector"%>
<%
    String electionIdStr = request.getParameter("election_id");
    if (electionIdStr != null && !electionIdStr.isEmpty()) {
        int electionId = Integer.parseInt(electionIdStr);
        
        Connection con = null;
        PreparedStatement ps = null;
        try {
            con = db_connector.getConnection();

            // Update the start_date to the current date and time
            String updateQuery = "UPDATE elections SET start_date = NOW(), status = 'Started' WHERE election_id = ?";
            ps = con.prepareStatement(updateQuery);
            ps.setInt(1, electionId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                out.println("Election started successfully.");
            } else {
                out.println("Election update failed.");
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
