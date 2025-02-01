<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Election Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>

    <script>
        var selectedElectionId = null;
        var actionType = "";

        function showModal(electionId, type) {
            selectedElectionId = electionId;
            actionType = type;

            let message = "";
            if (type === "start") {
                message = "Are you sure you want to start this election?";
            } else if (type === "end") {
                message = "Are you sure you want to end this election?";
            } else if (type === "delete") {
                message = "Are you sure you want to delete this election?";
            }

            $("#modalText").text(message);
            $("#confirmModal").removeClass("hidden");
        }

        function confirmAction() {
            let url = "";
            if (actionType === "start") {
                url = "startElection.jsp";
            } else if (actionType === "end") {
                url = "endElection.jsp";
            } else if (actionType === "delete") {
                url = "deleteElection.jsp";
            }

            $.ajax({
                url: url,
                type: "POST",
                data: { election_id: selectedElectionId },
                success: function (response) {
                    $("#confirmModal").addClass("hidden");
                    location.reload();
                },
                error: function (xhr, status, error) {
                    alert("An error occurred: " + error);
                }
            });
        }

        function cancelAction() {
            $("#confirmModal").addClass("hidden");
        }
    </script>
</head>
<body class="bg-gray-100 font-sans flex flex-col md:flex-row h-screen">

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
                <a href="admin_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Dashboard</span>
                </a>
            </div>
            <div class="px-6 py-3 bg-gray-300 cursor-pointer">
                <a href="electionmanagement.jsp" class="flex items-center text-gray-700">
                    <span class="ml-3">Election Management</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="UserManagement.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Users Management</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="./CandidateManagement.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Candidate Management</span>
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
    <div class="w-full items-center p-4 md:p-8">
        <div class="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow-lg">
            <header class="mb-6">
                <h1 class="text-3xl font-bold text-gray-800">Election Management</h1>
                <p class="text-gray-700 mb-4">Manage all ongoing and upcoming elections here.</p>
                <button onclick="location.href = 'add_election_handler.jsp'" 
                    class="bg-emerald-500 text-white px-4 py-2 my-5 rounded hover:bg-emerald-600">
                    Add New Election
                </button>
            </header>

            <!-- Election Management Section -->
            <div class="mt-8 bg-white p-6 rounded-lg shadow">
                <div class="overflow-x-auto">
                    <table class="min-w-full border-collapse border border-gray-300">
                        <thead>
                            <tr>
                                <th class="border border-gray-300 p-3 bg-gray-50 text-left">Election</th>
                                <th class="border border-gray-300 p-3 bg-gray-50 text-left">Status</th>
                                <th class="border border-gray-300 p-3 bg-gray-50 text-left">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;

                                try {
                                    con = db_connector.getConnection();
                                    String query = "SELECT election_id, `election name`, start_date, end_date FROM elections";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();

                                    while (rs.next()) {
                                        int electionId = rs.getInt("election_id");
                                        String electionName = rs.getString("election name");
                                        String status = "Upcoming";

                                        if (rs.getTimestamp("start_date") != null && rs.getTimestamp("end_date") == null) {
                                            status = "Started";
                                        } else if (rs.getTimestamp("start_date") != null && rs.getTimestamp("end_date") != null) {
                                            status = "Ended";
                                        }

                                        out.println("<tr id='row-" + electionId + "' class='hover:bg-gray-50'>");
                                        out.println("<td class='border border-gray-300 p-3'>" + electionName + "</td>");
                                        out.println("<td class='border border-gray-300 p-3'>" + status + "</td>");
                                        out.println("<td class='border border-gray-300 p-3'>");

                                        if (status.equals("Upcoming")) {
                                            out.println("<button class='px-3 py-1 bg-pink-500 text-white rounded' onclick='showModal(" + electionId + ", \"start\")'>Start</button> ");
                                        }
                                        if (status.equals("Started")) {
                                            out.println("<button class='px-3 py-1 bg-yellow-500 text-white rounded' onclick='showModal(" + electionId + ", \"end\")'>End</button> ");
                                        }
                                        out.println("<button class='px-3 py-1 bg-green-500 text-white rounded' onclick=\"location.href='updateElection.jsp?id=" + electionId + "'\">Update</button>");
                                        out.println("<button class='px-3 py-1 bg-red-500 text-white rounded' onclick='showModal(" + electionId + ", \"delete\")'>Delete</button> ");
                                        out.println("</td></tr>");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Confirmation Modal -->
    <div id="confirmModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
        <div class="bg-white p-6 rounded-lg shadow-lg text-center">
            <h2 id="modalTitle" class="text-xl font-bold mb-4 text-gray-800">Confirm Action</h2>
            <p id="modalText" class="text-gray-600 mb-4">Are you sure you want to perform this action?</p>
            <div class="flex justify-center space-x-4">
                <button id="confirmAction" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-md" onclick="confirmAction()">Confirm</button>
                <button onclick="cancelAction()" class="bg-gray-300 hover:bg-gray-400 text-gray-700 px-4 py-2 rounded-md">Cancel</button>
            </div>
        </div>
    </div>

</body>
</html>
