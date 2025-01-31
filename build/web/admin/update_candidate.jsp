<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Candidate</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans p-8">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-gray-800 mb-4">Update Candidate</h1>
        
        <%
            // Display success message if form is submitted
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String candidateIdStr = request.getParameter("candidate_id");
                int candidateId = Integer.parseInt(candidateIdStr);
                String candidateName = request.getParameter("candidate_name");
                String partyName = request.getParameter("party_name");
                String description = request.getParameter("description");

                Connection con = null;
                PreparedStatement ps = null;

                try {
                    con = db_connector.getConnection();
                    String query = "UPDATE candidates SET name = ?, party_name = ?, description = ? WHERE candidate_id = ?";
                    ps = con.prepareStatement(query);
                    ps.setString(1, candidateName);
                    ps.setString(2, partyName);
                    ps.setString(3, description);
                    ps.setInt(4, candidateId);
                    int rowsUpdated = ps.executeUpdate();

                    if (rowsUpdated > 0) {
                        String message = "Candidate updated successfully!";
                        String messageClass = "text-green-500"; // Success message color
        %>
                        <p class="<%= messageClass %> mb-4"><%= message %></p>
        <%
                    } else {
                        String message = "Failed to update candidate.";
                        String messageClass = "text-red-500"; // Error message color
        %>
                        <p class="<%= messageClass %> mb-4"><%= message %></p>
        <%
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    String message = "Error updating candidate: " + e.getMessage();
                    String messageClass = "text-red-500"; // Error message color
        %>
                    <p class="<%= messageClass %> mb-4"><%= message %></p>
        <%
                } finally {
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }

            // Fetch candidate details based on candidate_id
            String candidateIdStr = request.getParameter("id");
            int candidateId = Integer.parseInt(candidateIdStr);
            Connection con = null;
            PreparedStatement ps = null;
            ResultSet rs = null;
            
            try {
                con = db_connector.getConnection();
                String query = "SELECT c.candidate_id, c.name, c.party_name, c.description, e.`election name` AS election_name " +
                               "FROM candidates c " +
                               "JOIN elections e ON c.election_id = e.election_id " +
                               "WHERE c.candidate_id = ?";
                ps = con.prepareStatement(query);
                ps.setInt(1, candidateId);
                rs = ps.executeQuery();

                if (rs.next()) {
                    String candidateName = rs.getString("name");
                    String partyName = rs.getString("party_name");
                    String description = rs.getString("description");
                    String electionName = rs.getString("election_name"); // Fetch election name
        %>
        
        <!-- Update Candidate Form -->
        <form action="updateCandidate.jsp?id=<%= candidateId %>" method="post">
            <input type="hidden" name="candidate_id" value="<%= candidateId %>">
            <div class="mb-4">
                <label class="block text-gray-700">Candidate Name</label>
                <input type="text" name="candidate_name" value="<%= candidateName %>" class="w-full p-2 border border-gray-300 rounded mt-2" required>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Party Name</label>
                <input type="text" name="party_name" value="<%= partyName %>" class="w-full p-2 border border-gray-300 rounded mt-2">
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Description</label>
                <textarea name="description" rows="4" class="w-full p-2 border border-gray-300 rounded mt-2"><%= description %></textarea>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Election Name</label>
                <input type="text" value="<%= electionName %>" class="w-full p-2 border border-gray-300 rounded mt-2 bg-gray-100" readonly>
            </div>

            <button type="submit" class="bg-emerald-500 text-white px-4 py-2 rounded hover:bg-emerald-600">Update Candidate</button>
        </form>
        
        <% 
                } else {
                    out.println("<p class='text-red-500'>Candidate not found.</p>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p class='text-red-500'>Error fetching candidate data: " + e.getMessage() + "</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        
        <!-- Back to Candidate Management Link -->
        <a href="CandidateManagement.jsp" class="text-blue-500 mt-4 inline-block">Back to Candidate Management</a>
    </div>
</body>
</html>