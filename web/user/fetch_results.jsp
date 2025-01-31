<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>

<%
    String electionId = request.getParameter("election_id");

    if (electionId != null && !electionId.isEmpty()) {
        Connection conn = db_connector.getConnection();
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            String query = "SELECT c.name, c.party_name, COUNT(v.vote_id) AS vote_count " +
                           "FROM votes v " +
                           "JOIN candidates c ON v.candidate_id = c.candidate_id " +
                           "WHERE v.election_id = ? " +
                           "GROUP BY c.name, c.party_name " +
                           "ORDER BY vote_count DESC";
            
            stmt = conn.prepareStatement(query);
            stmt.setInt(1, Integer.parseInt(electionId));
            rs = stmt.executeQuery();

            while (rs.next()) {
                String candidateName = rs.getString("name");
                String partyName = rs.getString("party_name");
                int voteCount = rs.getInt("vote_count");
%>
                <div class="border-b py-2 flex justify-between">
                    <span class="text-lg font-medium"><%= candidateName %> (<%= partyName %>)</span>
                    <span class="text-lg font-bold text-gray-800"><%= voteCount %> votes</span>
                </div>
<%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
        }
    }
%>
