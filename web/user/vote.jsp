<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<%
    String voterId = request.getParameter("voter_id");
    String candidateId = request.getParameter("candidate_id");

    if (voterId != null && candidateId != null) {
        Connection conn = db_connector.getConnection();
        try {
            String insertVote = "INSERT INTO votes (voter_id, candidate_id, election_id) " +
                                "SELECT ?, ?, election_id FROM elections WHERE status = 'Started' LIMIT 1";
            PreparedStatement stmt = conn.prepareStatement(insertVote);
            stmt.setInt(1, Integer.parseInt(voterId));
            stmt.setInt(2, Integer.parseInt(candidateId));
            stmt.executeUpdate();
            response.getWriter().write("success");
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("error");
        } finally {
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>
