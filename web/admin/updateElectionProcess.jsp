<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Election Process</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-lg">
<%
    String electionId = request.getParameter("electionId");
    String electionName = request.getParameter("electionName");
    String description = request.getParameter("description");
    String message = "";

    if (electionId != null && electionName != null && description != null) {
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String status = "";

        try {
            con = db_connector.getConnection();
            String query = "SELECT status FROM elections WHERE election_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, electionId);
            rs = ps.executeQuery();

            if (rs != null && rs.next()) {
                status = rs.getString("status");

                if ("pending".equalsIgnoreCase(status)) {
                    String updateQuery = "UPDATE elections SET `election name` = ?, description = ? WHERE election_id = ?";
                    ps = con.prepareStatement(updateQuery);
                    ps.setString(1, electionName);
                    ps.setString(2, description);
                    ps.setString(3, electionId);

                    int result = ps.executeUpdate();
                    if (result > 0) {
                        message = "Election updated successfully!";
                    } else {
                        message = "Failed to update election. Please try again.";
                    }
                } else {
                    message = "The election cannot be updated because its status is not 'pending'.";
                }
            } else {
                message = "No election found with the provided ID.";
            }
        } catch (SQLException e) {
            message = "An error occurred: " + e.getMessage();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        message = "Invalid data provided. Please try again.";
    }
%>
        <h1 class="text-2xl font-bold text-gray-800 mb-6">Update Election Process</h1>
        <p class="text-gray-700 text-lg mb-4"><%= message %></p>
        <div class="flex justify-center">
            <a href="updateElection.jsp?id=<%= electionId %>" class="px-4 py-2 bg-blue-600 text-white font-semibold rounded-md shadow hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                Back to Update Election
            </a>
        </div>
    </div>
</body>
</html>