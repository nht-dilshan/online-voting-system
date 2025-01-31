<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Candidate</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans p-8">
    <div class="max-w-2xl mx-auto bg-white p-6 rounded-lg shadow-lg">
        <h1 class="text-3xl font-bold text-gray-800 mb-4">Add New Candidate</h1>

        <!-- Display success or error message -->
        <% 
            String message = "";
            String messageClass = "text-gray-700"; // Default text color
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                String candidateName = request.getParameter("candidate_name");
                String partyName = request.getParameter("party_name");
                String description = request.getParameter("description");
                int electionId = Integer.parseInt(request.getParameter("election_id"));

                Connection con = null;
                PreparedStatement ps = null;
                try {
                    con = db_connector.getConnection();
                    String query = "INSERT INTO candidates (name, party_name, description, election_id) VALUES (?, ?, ?, ?)";
                    ps = con.prepareStatement(query);
                    ps.setString(1, candidateName);
                    ps.setString(2, partyName);
                    ps.setString(3, description);
                    ps.setInt(4, electionId);

                    int result = ps.executeUpdate();

                    if (result > 0) {
                        message = "Candidate added successfully!";
                        messageClass = "text-green-500"; // Success message color
                    } else {
                        message = "Error adding candidate.";
                        messageClass = "text-red-500"; // Error message color
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    message = "Error: " + e.getMessage();
                    messageClass = "text-red-500"; // Error message color
                } finally {
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        
        <!-- Display the message -->
        <p class="<%= messageClass %> mb-4"><%= message %></p>

        <form action="add_candidate.jsp" method="post">
            <div class="mb-4">
                <label class="block text-gray-700">Candidate Name</label>
                <input type="text" name="candidate_name" class="w-full p-2 border border-gray-300 rounded mt-2" required>
            </div>

            <!-- Dropdown for Party Name -->
            <div class="mb-4">
                <label class="block text-gray-700">Party Name</label>
                <select name="party_name" class="w-full p-2 border border-gray-300 rounded mt-2" required>
                    <option value="">Select a Party</option>
                    <option value="Party1">Party1</option>
                    <option value="Party2">Party2</option>
                    <option value="Party3">Party3</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="block text-gray-700">Description</label>
                <textarea name="description" rows="4" class="w-full p-2 border border-gray-300 rounded mt-2"></textarea>
            </div>

            <!-- Dropdown for Election Selection -->
            <div class="mb-4">
                <label class="block text-gray-700">Election</label>
                <select name="election_id" class="w-full p-2 border border-gray-300 rounded mt-2" required>
                    <option value="">Select an Election</option>
                    <%
                        Connection con = null;
                        PreparedStatement ps = null;
                        ResultSet rs = null;
                        try {
                            con = db_connector.getConnection();
                            String query = "SELECT election_id, `election name` FROM elections";
                            ps = con.prepareStatement(query);
                            rs = ps.executeQuery();
                            while (rs.next()) {
                                int electionId = rs.getInt("election_id");
                                String electionName = rs.getString("election name");
                    %>
                                <option value="<%= electionId %>"><%= electionName %></option>
                    <%
                            }
                        } catch (SQLException e) {
                            e.printStackTrace();
                        } finally {
                            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </select>
            </div>

            <button type="submit" class="bg-emerald-500 text-white px-4 py-2 rounded hover:bg-emerald-600">Add Candidate</button>
        </form>

        <a href="CandidateManagement.jsp" class="text-blue-500 mt-4 inline-block">Back to Candidate Management</a>
    </div>
</body>
</html>
