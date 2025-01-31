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
        <h1 class="text-3xl font-bold text-gray-800 mb-4">Candidate Updated</h1>

        <%
            String candidateIdStr = request.getParameter("candidate_id");
            String candidateName = request.getParameter("candidate_name");
            String partyName = request.getParameter("party_name");
            String description = request.getParameter("description");
            int candidateId = Integer.parseInt(candidateIdStr);
            
            if (candidateIdStr != null && !candidateName.isEmpty()) {
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
                        out.println("<p class='text-green-500'>Candidate updated successfully!</p>");
                    } else {
                        out.println("<p class='text-red-500'>Error: Candidate not found or update failed.</p>");
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                    out.println("<p class='text-red-500'>Error updating candidate: " + e.getMessage() + "</p>");
                } finally {
                    try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                    try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            } else {
                out.println("<p class='text-red-500'>Error: All fields are required!</p>");
            }
        %>

        <br>
        <a href="CandidateManagement.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Back to Candidate List</a>
    </div>
</body>
</html>
