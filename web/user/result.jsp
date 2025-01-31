<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Election Results</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="h-screen flex bg-gray-100 font-sans">

    <!-- Sidebar -->
    <div class="bg-white shadow-lg h-full w-full md:w-64 fixed md:relative flex flex-col">
       <div class="p-6 border-b border-gray-100">
            <a href="../index.jsp" class="logo-font inline-block">
                <span class="font-bold text-2xl bg-gradient-to-r from-emerald-500 to-emerald-700 bg-clip-text text-transparent hover:from-emerald-600 hover:to-emerald-800 transition-all duration-300 transform hover:scale-105">
                    Vote<span class="text-emerald-500">Stream</span>
                </span>
            </a>
        </div>
        <nav class="mt-6 flex-grow">
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="user_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Home</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="votingArea.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Voting Area</span>
                </a>
            </div>
            <div class="px-6 py-3 bg-gray-300 cursor-pointer">
                <a href="result.jsp" class="flex items-center text-gray-700">
                    <span class="ml-3">Results</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="profile.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Profile</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="userAbout.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">About Us</span>
                </a>
            </div>
            <div class="px-6 py-3 mt-auto cursor-pointer">
                <form action="logout.jsp" method="post">
                    <button type="submit" class="w-full bg-red-500 text-white py-2 rounded hover:bg-red-600">Logout</button>
                </form>
            </div>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="w-full flex flex-col items-center p-4 md:p-8 justify-center h-full">
        <div class="container mx-auto h-full">
            <!-- Title Section -->
            <h1 class="text-3xl font-bold mb-6 text-gray-800">Election Results</h1>

            <!-- Dropdown to Select Ended Election -->
            <div class="mb-6">
                <label for="electionSelect" class="block text-gray-700 font-medium mb-2">Select an Ended Election:</label>
                <select id="electionSelect" class="w-full max-w-md border border-gray-300 rounded-md py-2 px-4 focus:outline-none focus:ring-2 focus:ring-emerald-500">
                    <option value="">-- Select an Election --</option>
                    <%
                        Connection conn = null;
                        PreparedStatement stmt = null;
                        ResultSet rs = null;

                        try {
                            conn = db_connector.getConnection();
                            if (conn != null) {
                                String query = "SELECT election_id, `election name` FROM elections WHERE status = 'Ended'";
                                stmt = conn.prepareStatement(query);
                                rs = stmt.executeQuery();

                                while (rs.next()) {
                                    int electionId = rs.getInt("election_id");
                                    String electionName = rs.getString("election name");
                    %>
                    <option value="<%= electionId %>"><%= electionName %></option>
                    <%
                                }
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException ignore) {}
                            if (stmt != null) try { stmt.close(); } catch (SQLException ignore) {}
                            if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                        }
                    %>
                </select>
            </div>

            <!-- Message for No Selection -->
            <div id="message" class="text-gray-600 text-lg">
                Please select an ended election to view results.
            </div>

            <!-- Results Section (Initially Hidden) -->
            <div id="resultSection" class="hidden bg-white shadow-lg rounded-lg overflow-hidden p-6 mt-6">
                <h2 class="text-xl font-semibold text-gray-800 mb-4">Election Results</h2>
                <div id="resultContent" class="text-gray-600">
                    <!-- Results will be dynamically inserted here -->
                </div>
            </div>
        </div>
    </div>

    <!-- JavaScript for Handling Dropdown Selection -->
    <script>
        $(document).ready(function () {
            $("#electionSelect").change(function () {
                var electionId = $(this).val();
                if (electionId) {
                    $("#message").hide();
                    $("#resultSection").removeClass("hidden");

                    $.post("fetch_results.jsp", { election_id: electionId }, function (response) {
                        $("#resultContent").html(response);
                    });
                } else {
                    $("#message").show();
                    $("#resultSection").addClass("hidden");
                }
            });
        });
    </script>

</body>
</html>
