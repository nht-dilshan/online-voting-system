<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Election</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <script>
        function goBack() {
            window.history.back();
        }
    </script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

    <!-- Main Container -->
    <div class="w-full max-w-3xl mx-auto p-6">
        <div class="bg-white rounded-xl shadow-2xl overflow-hidden">
            <!-- Header Section -->
            <div class="bg-emerald-600 text-white p-6">
                <h1 class="text-3xl font-bold mb-2">Update Election</h1>
                <p class="text-emerald-100">Modify the details of your existing election.</p>
            </div>

            <!-- Form Container -->
            <div class="p-8">
                <%
                    String electionIdParam = request.getParameter("id");
                    String message = "";
                    String messageType = "";
                    if (electionIdParam == null || electionIdParam.isEmpty()) {
                        out.println("<h3 class='text-red-500'>No election ID provided.</h3>");
                        return;
                    }

                    int electionId = Integer.parseInt(electionIdParam);
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;
                    String electionName = "";
                    String description = "";

                    try {
                        con = db_connector.getConnection();
                        String query = "SELECT * FROM elections WHERE election_id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, electionId);
                        rs = ps.executeQuery();

                        if (rs != null && rs.next()) {
                            electionName = rs.getString("election name");
                            description = rs.getString("description");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        electionName = "Error";
                        description = "Error retrieving election details";
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (ps != null) ps.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }

                    // Handling update submission
                    if ("POST".equalsIgnoreCase(request.getMethod())) {
                        electionName = request.getParameter("electionName");
                        description = request.getParameter("description");

                        if (electionName != null && !electionName.trim().isEmpty() && description != null && !description.trim().isEmpty()) {
                            try {
                                con = db_connector.getConnection();
                                String updateQuery = "UPDATE elections SET `election name` = ?, description = ? WHERE election_id = ?";
                                ps = con.prepareStatement(updateQuery);
                                ps.setString(1, electionName);
                                ps.setString(2, description);
                                ps.setInt(3, electionId);

                                int result = ps.executeUpdate();
                                if (result > 0) {
                                    message = "Election updated successfully!";
                                    messageType = "success";
                                } else {
                                    message = "Failed to update election. Please try again.";
                                    messageType = "error";
                                }
                            } catch (SQLException e) {
                                message = "An error occurred: " + e.getMessage();
                                messageType = "error";
                            } finally {
                                try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
                                try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
                            }
                        } else {
                            message = "All fields are required!";
                            messageType = "error";
                        }
                    }
                %>

                <% if (!message.isEmpty()) { %>
                    <div class="bg-<%= messageType.equals("success") ? "green" : "red" %>-50 border border-<%= messageType.equals("success") ? "green" : "red" %>-200 text-<%= messageType.equals("success") ? "green" : "red" %>-700 px-4 py-3 rounded relative mb-4" role="alert">
                        <strong class="font-bold"><%= messageType.equals("success") ? "Success!" : "Error" %></strong>
                        <span class="block sm:inline"><%= message %></span>
                    </div>
                <% } %>

                <!-- Update Election Form -->
                <form action="updateElection.jsp?id=<%= electionId %>" method="post" class="space-y-6">
                    <input type="hidden" name="electionId" value="<%= electionId %>">
                    
                    <!-- Election Name Field -->
                    <div>
                        <label for="electionName" class="block text-gray-700 font-semibold mb-2">Election Name</label>
                        <input 
                            type="text" 
                            id="electionName" 
                            name="electionName" 
                            value="<%= electionName %>" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 transition duration-300"
                            required
                        >
                    </div>

                    <!-- Description Field -->
                    <div>
                        <label for="description" class="block text-gray-700 font-semibold mb-2">Description</label>
                        <textarea 
                            id="description" 
                            name="description" 
                            rows="4" 
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500 transition duration-300"
                            required
                        ><%= description %></textarea>
                    </div>

                    <!-- Action Buttons -->
                    <div class="flex justify-between items-center">
                         <a 
                    href="electionmanagement.jsp" 
                    class="text-gray-600 hover:text-emerald-600 transition duration-300"
                >
                    ← Back to Election Management
                </a>
                        <input 
                            type="submit" 
                            value="Update Election" 
                            class="px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition duration-300 cursor-pointer"
                        >
                    </div>
                </form>
            </div>
        </div>
    </div>

</body>
</html>
