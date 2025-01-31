<%@page import="classes.db_connector"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Candidate Management</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>

        <script>
            function deleteCandidate(candidateId) {
                if (confirm('Are you sure you want to delete this candidate?')) {
                    $.ajax({
                        url: 'deleteCandidate.jsp', // URL for the delete action
                        type: 'POST',
                        data: {candidate_id: candidateId}, // Passing candidate_id using POST
                        success: function (response) {
                            if (response.trim() === "Candidate deleted successfully.") {
                                $('#row-' + candidateId).remove(); // Remove the row from the table on success
                                alert("Candidate deleted successfully.");
                            } else {
                                alert(response); // Show error message from the backend
                            }
                        },
                        error: function (xhr, status, error) {
                            alert("An error occurred: " + error); // Handle errors from the AJAX request
                        }
                    });
                }
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
                <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                    <a href="electionmanagement.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                        <span class="ml-3">Election Management</span>
                    </a>
                </div>
                <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                    <a href="UserManagement.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                        <span class="ml-3">Users Management</span>
                    </a>
                </div>
                <div class="px-6 py-3 bg-gray-300 cursor-pointer">
                    <a href="CandidateManagement.jsp" class="flex items-center text-gray-700">
                        <span class="ml-3">Candidate Management</span>
                    </a>
                </div>
                <div class="px-6 py-3 mt-auto  cursor-pointer">
                    <form action="logout.jsp" method="post">
                        <button type="submit" class="w-full bg-red-500 text-white py-2 rounded hover:bg-red-600">Logout</button>
                    </form>
                </div>
            </nav>
        </div>

        <!-- Main Content -->
        <div class="w-full items-center p-4 md:p-8">
            <div class="p-6 bg-white rounded-lg shadow-lg">
                <!-- Header Section -->
                <header class="mb-6">
                    <h1 class="text-3xl font-bold text-gray-800">Candidate Management</h1>
                    <button 
                        onclick="location.href = 'add_candidate.jsp'" 
                        class="bg-emerald-500 text-white px-4 py-2 my-5 rounded mb-4 hover:bg-emerald-600">
                        Add New Candidate
                    </button>
                </header>

                <!-- Candidate Management Section -->
                <div class="mt-8 bg-white p-6 rounded-lg shadow">
                    <h2 class="text-xl font-bold text-gray-800 mb-4">Candidate List</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full border-collapse border border-gray-300">
                            <thead>
                                <tr>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Candidate Name</th>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Party Name</th>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Description</th>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    Connection con = null;
                                    Statement stmt = null;
                                    ResultSet rs = null;
                                    try {
                                        con = db_connector.getConnection();
                                        String query = "SELECT candidate_id, name, party_name, description FROM candidates";

                                        stmt = con.createStatement();
                                        rs = stmt.executeQuery(query);

                                        while (rs.next()) {
                                            int candidateId = rs.getInt("candidate_id");
                                            String candidateName = rs.getString("name");
                                            String partyName = rs.getString("party_name");
                                            String description = rs.getString("description");
                                %>
                                <tr id="row-<%= candidateId%>" class="hover:bg-gray-50">
                                    <td class="border border-gray-300 p-3"><%= candidateName%></td>
                                    <td class="border border-gray-300 p-3"><%= partyName != null ? partyName : "Independent"%></td>
                                    <td class="border border-gray-300 p-3"><%= description != null ? description : "N/A"%></td>
                                    <td class="border border-gray-300 p-3">
                                        <!-- Update Button -->
                                        <button class="px-3 py-1 bg-green-500 text-white rounded" onclick="window.location.href = 'update_candidate.jsp?id=<%= candidateId%>'">Update</button>
                                        <!-- Delete Button -->
                                        <button class="px-3 py-1 bg-red-500 text-white rounded" onclick="deleteCandidate(<%= candidateId%>)">Delete</button>
                                    </td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        out.println("<tr><td colspan='4' class='border border-gray-300 p-3 text-center text-red-500'>Error loading data: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        try {
                                            if (stmt != null) {
                                                stmt.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        try {
                                            if (con != null) {
                                                con.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Footer -->
                <footer class="mt-8 text-center text-gray-500">
                    &copy; 2025 Voting System. All rights reserved.
                </footer>
            </div>
        </div>
    </body>
</html>
