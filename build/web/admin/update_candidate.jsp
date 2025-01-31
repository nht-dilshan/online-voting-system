<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Candidate</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center py-12">
    <div class="w-full max-w-2xl">
        <div class="bg-white rounded-xl shadow-2xl overflow-hidden">
            <!-- Header Section -->
            <div class="bg-emerald-600 text-white p-6">
                <h1 class="text-3xl font-bold mb-2">Update Candidate</h1>
                <p class="text-emerald-100">Modify candidate details for your election</p>
            </div>

            <!-- Main Content -->
            <div class="p-8">
                <%
                    // Display success/error messages
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
                %>
                                <div class="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                                    <strong class="font-bold">Success! </strong>
                                    <span class="block sm:inline">Candidate updated successfully.</span>
                                </div>
                <%
                            } else {
                %>
                                <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                                    <strong class="font-bold">Error! </strong>
                                    <span class="block sm:inline">Failed to update candidate.</span>
                                </div>
                <%
                            }
                        } catch (SQLException e) {
                %>
                            <div class="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                                <strong class="font-bold">Error! </strong>
                                <span class="block sm:inline"><%= e.getMessage() %></span>
                            </div>
                <%
                        } finally {
                            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    }

                    // Fetch candidate details
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
                            String electionName = rs.getString("election_name");
                %>
                
                <!-- Candidate Update Form -->
                <form action="updateCandidate.jsp?id=<%= candidateId %>" method="post" class="space-y-6">
                    <input type="hidden" name="candidate_id" value="<%= candidateId %>">
                    
                    <!-- Candidate Name -->
                    <div>
                        <label class="block text-gray-700 font-semibold mb-2">Candidate Name</label>
                        <input 
                            type="text" 
                            name="candidate_name" 
                            value="<%= candidateName %>" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 transition duration-300" 
                            required
                        >
                    </div>

                    <!-- Party Name -->
                    <div>
                        <label class="block text-gray-700 font-semibold mb-2">Party Name</label>
                        <input 
                            type="text" 
                            name="party_name" 
                            value="<%= partyName %>" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 transition duration-300"
                        >
                    </div>

                    <!-- Description -->
                    <div>
                        <label class="block text-gray-700 font-semibold mb-2">Description</label>
                        <textarea 
                            name="description" 
                            rows="4" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 transition duration-300"
                        ><%= description %></textarea>
                    </div>

                    <!-- Election Name (Read-only) -->
                    <div>
                        <label class="block text-gray-700 font-semibold mb-2">Election Name</label>
                        <input 
                            type="text" 
                            value="<%= electionName %>" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg bg-gray-100 cursor-not-allowed" 
                            readonly
                        >
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex justify-between items-center">
                        <a 
                            href="CandidateManagement.jsp" 
                            class="text-gray-600 hover:text-emerald-600 transition duration-300"
                        >
                            ← Back to Candidate Management
                        </a>
                        <button 
                            type="submit" 
                            class="px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition duration-300"
                        >
                            Update Candidate
                        </button>
                    </div>
                </form>
                
                <% 
                    } else {
                        out.println("<p class='text-red-500'>Candidate not found.</p>");
                    }
                } catch (SQLException e) {
                    out.println("<p class='text-red-500'>Error fetching candidate data: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
                %>
            </div>
        </div>
    </div>
</body>
</html>