<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Candidate</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-100 font-sans p-8">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-gray-800 mb-4">Update Candidate</h1>

        <%-- Backend processing --%>
        <%
            String message = "";
            String messageType = ""; 
            
            String candidateIdStr = request.getParameter("candidate_id");
            String candidateName = request.getParameter("candidate_name");
            String partyName = request.getParameter("party_name");
            String description = request.getParameter("description");
            int candidateId = 0;

            try {
                candidateId = Integer.parseInt(candidateIdStr);
            } catch (NumberFormatException e) {
                message = "Invalid Candidate ID.";
                messageType = "error";
            }

            if (candidateId > 0 && candidateName != null && !candidateName.trim().isEmpty()) {
                Connection con = null;
                PreparedStatement ps = null;

                try {
                    con = db_connector.getConnection();
                    String updateQuery = "UPDATE candidates SET name = ?, party_name = ?, description = ? WHERE candidate_id = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setString(1, candidateName);
                    ps.setString(2, partyName);
                    ps.setString(3, description);
                    ps.setInt(4, candidateId);

                    int rowsUpdated = ps.executeUpdate();
                    if (rowsUpdated > 0) {
                        message = "Candidate updated successfully!";
                        messageType = "success";
                    } else {
                        message = "Error: Candidate not found or update failed.";
                        messageType = "error";
                    }
                } catch (SQLException e) {
                    message = "Error updating candidate: " + e.getMessage();
                    messageType = "error";
                } finally {
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                message = "Error: All fields are required!";
                messageType = "error";
            }
        %>

        <% if (!message.isEmpty()) { %>
            <div class="bg-<%= messageType.equals("success") ? "green" : "red" %>-50 border border-<%= messageType.equals("success") ? "green" : "red" %>-200 text-<%= messageType.equals("success") ? "green" : "red" %>-700 px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold"><%= messageType.equals("success") ? "Success!" : "Error" %></strong>
                <span class="block sm:inline"><%= message %></span>
            </div>
        <% } %>

        <form action="update_candidate.jsp" method="post" class="space-y-6">
            <input type="hidden" name="candidate_id" value="<%= candidateId %>">
            
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Candidate Name</label>
                <input type="text" name="candidate_name" value="<%= candidateName %>" class="w-full px-4 py-3 border border-gray-300 rounded-lg" required>
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">Party Name</label>
                <input type="text" name="party_name" value="<%= partyName %>" class="w-full px-4 py-3 border border-gray-300 rounded-lg">
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">Description</label>
                <textarea name="description" rows="4" class="w-full px-4 py-3 border border-gray-300 rounded-lg"><%= description %></textarea>
            </div>

            <div>
                <label class="block text-gray-700 font-semibold mb-2">Election Name</label>
                <%
                    String electionName = "";
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    try {
                        con = db_connector.getConnection();
                        String query = "SELECT e.`election name` FROM elections e JOIN candidates c ON e.election_id = c.election_id WHERE c.candidate_id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, candidateId);
                        rs = ps.executeQuery();

                        if (rs.next()) {
                            electionName = rs.getString("election name");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                        try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
                <input type="text" value="<%= electionName %>" class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100 cursor-not-allowed" readonly>
            </div>

            <div class="flex justify-between items-center">
                <a href="CandidateManagement.jsp" class="text-gray-600 hover:text-emerald-600 transition duration-300">← Back to Candidate Management</a>
                <button type="submit" class="px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition duration-300">Update Candidate</button>
            </div>
        </form>
    </div>
</body>
</html>
