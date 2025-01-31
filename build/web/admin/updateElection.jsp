<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
                %>

                <!-- Update Election Form -->
                <form action="updateElectionProcess.jsp" method="post" class="space-y-6">
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
                        <button 
                            type="button" 
                            onclick="goBack()"
                            class="px-6 py-3 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition duration-300"
                        >
                            Cancel
                        </button>
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