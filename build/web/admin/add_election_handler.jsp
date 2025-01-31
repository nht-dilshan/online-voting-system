<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Election</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
    <div class="bg-white p-8 rounded-lg shadow-md w-full max-w-lg">
        <h1 class="text-2xl font-bold text-gray-800 mb-6">Add Election</h1>

<%
    // Define message variable
    String message = "";

    // Check if form was submitted
    if (request.getMethod().equalsIgnoreCase("POST")) {
        // Get form data
        String electionName = request.getParameter("electionName");
        String description = request.getParameter("description");

        // Database connection and query execution
        Connection con = null;
        PreparedStatement ps = null;

        try {
            // Establish connection
            con = db_connector.getConnection();

            // SQL query to insert election data
            String sql = "INSERT INTO elections (`election name`, description) VALUES (?, ?)";
            ps = con.prepareStatement(sql);

            // Set parameters
            ps.setString(1, electionName);
            ps.setString(2, description);

            // Execute query
            int result = ps.executeUpdate();

            if (result > 0) {
                message = "Election added successfully!";
            } else {
                message = "Failed to add election. Please try again.";
            }

        } catch (SQLException e) {
            message = "An error occurred: " + e.getMessage();
        } finally {
            // Close resources
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                message += " Error closing database connection.";
            }
        }
    }
%>

        <% if (!message.isEmpty()) { %>
            <p class="text-green-600 text-lg mb-4"><%= message %></p>
        <% } %>

        <form action="add_election_handler.jsp" method="POST" class="space-y-4">
            <!-- Election Name -->
            <div>
                <label for="electionName" class="block text-sm font-medium text-gray-700">Election Name</label>
                <input type="text" id="electionName" name="electionName" 
                    class="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500" 
                    placeholder="Enter election name" required>
            </div>

            <!-- Description -->
            <div>
                <label for="description" class="block text-sm font-medium text-gray-700">Description</label>
                <textarea id="description" name="description" rows="4" 
                    class="mt-1 p-2 block w-full rounded-md border-gray-300 shadow-sm focus:ring-blue-500 focus:border-blue-500" 
                    placeholder="Enter a brief description of the election"></textarea>
            </div>

            <!-- Buttons (Back + Submit) -->
            <div class="flex justify-between">
                <!-- Back Button -->
                <button type="button" onclick="goBack()"
                    class="px-4 py-2 bg-gray-400 text-white font-semibold rounded-md shadow hover:bg-gray-500 focus:outline-none focus:ring-2 focus:ring-gray-500">
                    Back
                </button>

                <!-- Submit Button -->
                <button type="submit" 
                    class="px-4 py-2 bg-blue-600 text-white font-semibold rounded-md shadow hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500">
                    Add Election
                </button>
            </div>
        </form>
    </div>

    <script>
        function goBack() {
            window.location.href = "electionmanagement.jsp"; // Redirect to election management page
        }
    </script>

</body>
</html>
