<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Election</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 font-sans">

    <!-- Main Content -->
    <div class="w-full p-4 md:p-8">
        <div class="max-w-2xl mx-auto p-4 md:p-6 bg-white rounded-lg shadow-lg">
            <!-- Header Section -->
            <header class="mb-6">
                <h1 class="text-2xl md:text-3xl font-bold text-gray-800">Update Election</h1>
                <p class="text-gray-700 mb-4">Update the details of the election below.</p>
            </header>

            <!-- Election Update Form -->
            <div class="bg-white p-4 md:p-6 rounded-lg shadow">
                <%
                    String electionIdParam = request.getParameter("id");
                    if (electionIdParam == null || electionIdParam.isEmpty()) {
                        out.println("<h3>No election ID provided.</h3>");
                        return;
                    }

                    int electionId = Integer.parseInt(electionIdParam);
                    Connection con = null;
                    PreparedStatement ps = null;
                    ResultSet rs = null;

                    try {
                        con = db_connector.getConnection();
                        String query = "SELECT * FROM elections WHERE election_id = ?";
                        ps = con.prepareStatement(query);
                        ps.setInt(1, electionId);
                        rs = ps.executeQuery();

                        if (rs != null && rs.next()) {
                            String electionName = rs.getString("election name");
                            String description = rs.getString("description");

                            // Populate form fields with election data
                            out.println("<form action='updateElectionProcess.jsp' method='post' class='space-y-4 md:space-y-6'>");
                            out.println("<input type='hidden' name='electionId' value='" + electionId + "'>");
                            out.println("<div>");
                            out.println("<label for='electionName' class='block text-gray-700 font-medium'>Election Name:</label>");
                            out.println("<input type='text' id='electionName' name='electionName' value='" + electionName + "' class='w-full px-4 py-2 border border-gray-300 rounded-md' required><br><br>");
                            out.println("</div>");
                            out.println("<div>");
                            out.println("<label for='description' class='block text-gray-700 font-medium'>Description:</label>");
                            out.println("<textarea id='description' name='description' class='w-full px-4 py-2 border border-gray-300 rounded-md' required>" + description + "</textarea><br><br>");
                            out.println("</div>");
                            out.println("<div class='text-right'>");
                            out.println("<input type='submit' value='Update Election' class='bg-emerald-500 text-white px-4 py-2 md:px-6 md:py-2 rounded-md hover:bg-emerald-600'>");
                            out.println("</div>");
                            out.println("</form>");
                        } else {
                            out.println("<h3>No election found with this ID.</h3>");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<h3>Error retrieving election details: " + e.getMessage() + "</h3>");
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
            </div>
        </div>
    </div>
</body>
</html>