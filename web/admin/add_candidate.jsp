<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Candidate</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

    <div class="w-full max-w-2xl bg-white shadow-2xl rounded-xl overflow-hidden">
        <div class="bg-emerald-600 text-white p-6">
            <h1 class="text-3xl font-bold">Add New Candidate</h1>
        </div>

        <div class="p-8">
            <%
                String message = "";
                String messageType = ""; // Will be used for SweetAlert
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String candidateName = request.getParameter("candidate_name");
                    String partyName = request.getParameter("party_name");
                    String description = request.getParameter("description");
                    int electionId = 0;
                    
                    try {
                        electionId = Integer.parseInt(request.getParameter("election_id"));
                    } catch (NumberFormatException e) {
                        message = "Please select a valid election.";
                        messageType = "error";
                    }

                    Connection con = null;
                    PreparedStatement ps = null;
                    try {
                        con = db_connector.getConnection();
                        
                        // Validate inputs
                        if (candidateName == null || candidateName.trim().isEmpty()) {
                            throw new SQLException("Candidate name cannot be empty");
                        }
                        
                        if (partyName == null || partyName.trim().isEmpty()) {
                            throw new SQLException("Please select a party");
                        }

                        String query = "INSERT INTO candidates (name, party_name, description, election_id) VALUES (?, ?, ?, ?)";
                        ps = con.prepareStatement(query);
                        ps.setString(1, candidateName.trim());
                        ps.setString(2, partyName);
                        ps.setString(3, description != null ? description.trim() : "");
                        ps.setInt(4, electionId);

                        int result = ps.executeUpdate();

                        if (result > 0) {
                            message = "Candidate added successfully!";
                            messageType = "success";
                        } else {
                            message = "Error adding candidate.";
                            messageType = "error";
                        }
                    } catch (SQLException e) {
                        message = "Error: " + e.getMessage();
                        messageType = "error";
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

            <form id="candidateForm" action="add_candidate.jsp" method="post" class="space-y-6">
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Candidate Name</label>
                    <input type="text" name="candidate_name" 
                           class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                           placeholder="Enter candidate's full name" 
                           required
                           maxlength="100">
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Party Name</label>
                    <select name="party_name" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                            required>
                        <option value="">Select Political Party</option>
                        <option value="National People's Power (NPP)">National People's Power (NPP)</option>
                        <option value="Samagi Jana Balawegaya (SJB)">Samagi Jana Balawegaya (SJB)</option>
                        <option value="Sri Lanka Podujana Peramuna (SLPP)">Sri Lanka Podujana Peramuna (SLPP)</option>
                        <option value="New Democratic Front (NDF)">New Democratic Front (NDF)</option>
                        <option value="Ilankai Tamil Arasu Kachchi (ITAK)">Ilankai Tamil Arasu Kachchi (ITAK)</option>
                        <option value="Sri Lanka Muslim Congress (SLMC)">Sri Lanka Muslim Congress (SLMC)</option>
                        <option value="Independent">Independent</option>
                        
                    </select>
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Description</label>
                    <textarea name="description" 
                              rows="4" 
                              class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                              placeholder="Brief candidate biography or platform summary"
                              maxlength="500"></textarea>
                </div>

                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Election</label>
                    <select name="election_id" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                            required>
                        <option value="">Select Election</option>
                        <%
                            Connection con = null;
                            PreparedStatement ps = null;
                            ResultSet rs = null;
                            try {
                                con = db_connector.getConnection();
                                String query = "SELECT election_id, `election name` FROM elections ORDER BY election_id"; // Ensure you're selecting the correct column name
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
                                try { 
                                    if (rs != null) rs.close(); 
                                    if (ps != null) ps.close(); 
                                    if (con != null) con.close(); 
                                } catch (SQLException e) { 
                                    e.printStackTrace(); 
                                }
                            }
                        %>
                    </select>
                </div>

                <div class="flex justify-between items-center">
                    <button type="submit" 
                            class="bg-emerald-600 text-white px-6 py-3 rounded-lg hover:bg-emerald-700 transition duration-300 transform hover:scale-105">
                        Add Candidate
                    </button>
                    <a href="CandidateManagement.jsp" 
                       class="text-emerald-600 hover:underline">Back to Candidate Management</a>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Use SweetAlert for displaying messages
        <% if (!message.isEmpty()) { %>
            Swal.fire({
                icon: '<%= messageType %>',
                title: '<%= messageType.equals("success") ? "Success!" : "Error" %>',
                text: '<%= message %>',
                confirmButtonColor: '<%= messageType.equals("success") ? "#10B981" : "#EF4444" %>'
            });
        <% } %>

        // Client-side form validation
        document.getElementById('candidateForm').addEventListener('submit', function(event) {
            const candidateName = document.querySelector('input[name="candidate_name"]').value.trim();
            const partyName = document.querySelector('select[name="party_name"]').value;
            const electionId = document.querySelector('select[name="election_id"]').value;

            if (!candidateName) {
                event.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    text: 'Candidate name cannot be empty'
                });
            }

            if (!partyName) {
                event.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    text: 'Please select a political party'
                });
            }

            if (!electionId) {
                event.preventDefault();
                Swal.fire({
                    icon: 'error',
                    title: 'Validation Error',
                    text: 'Please select an election'
                });
            }
        });
    </script>
</body>
</html>
