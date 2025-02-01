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
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">

    <div class="w-full max-w-2xl bg-white shadow-2xl rounded-xl overflow-hidden">
        <div class="bg-emerald-600 text-white p-6">
            <h1 class="text-3xl font-bold">Add New Election</h1>
        </div>

        <div class="p-8">
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
                <script>
                    Swal.fire({
                        icon: '<%= message.contains("success") ? "success" : "error" %>',
                        title: '<%= message.contains("success") ? "Success!" : "Error" %>',
                        text: '<%= message %>',
                        confirmButtonColor: '<%= message.contains("success") ? "#10B981" : "#EF4444" %>'
                    });
                </script>
            <% } %>

            <form action="add_election_handler.jsp" method="POST" class="space-y-6">
                <!-- Election Name -->
                <div>
                    <label for="electionName" class="block text-gray-700 font-semibold mb-2">Election Name</label>
                    <input type="text" id="electionName" name="electionName" 
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                        placeholder="Enter election name" required>
                </div>

                <!-- Description -->
                <div>
                    <label for="description" class="block text-gray-700 font-semibold mb-2">Description</label>
                    <textarea id="description" name="description" rows="4" 
                        class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500" 
                        placeholder="Enter a brief description of the election"></textarea>
                </div>

                <!-- Buttons (Back + Submit) -->
                <div class="flex justify-between items-center">
                    <!-- Back Button -->
                    <a href="electionmanagement.jsp" class="text-emerald-600 hover:underline">Back to Election Management </a>

                    <!-- Submit Button -->
                    <button type="submit" 
                        class="px-4 py-2 bg-emerald-600 text-white font-semibold rounded-md shadow hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-emerald-500">
                        Add Election
                    </button>
                </div>
            </form>
        </div>
    </div>

    <script>
        // Redirect to election management page
        function goBack() {
            window.location.href = "electionmanagement.jsp"; // Redirect to election management page
        }
    </script>

</body>
</html>
