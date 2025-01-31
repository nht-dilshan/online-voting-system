<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="classes.db_connector"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Connection"%>
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Voting System Admin Dashboard</title>
        <script src="https://cdn.tailwindcss.com"></script>
    </head>
    <body class="bg-gray-100 font-sans flex flex-col md:flex-row h-screen">

        <!-- Sidebar -->
        <div class="bg-white shadow-lg h-full w-full md:w-64 relative flex flex-col">
            <div class="p-6">
                <a href="#" class="font-bold text-lg text-emerald-500">VoteStream</a>
            </div>
            <nav class="mt-6 flex-grow">
                <div class="px-6 py-3 bg-gray-300 cursor-pointer">
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
                    <a href="UserManagement.jsp" class="flex items-center text-gray-700">
                        <span class="ml-3">User Management</span>
                    </a>
                </div>
                <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                    <a href="CandidateManagement.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
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
            <div class="p-6 bg-white rounded-lg shadow-lg">

                <!-- Header Section -->
                <header class="mb-6">
                    <h1 class="text-3xl font-bold text-gray-800">Admin Dashboard</h1>
                    <p class="text-gray-500">Manage and monitor elections, voters, and results</p>
                </header>

                <!-- Summary Statistics -->
                <div class="grid grid-cols-1 md:grid-cols-4 gap-6">
                    <div class="bg-white p-5 rounded-lg shadow">
                        <h2 class="text-sm font-semibold text-gray-600">Total Registered Voters</h2>
                        <p class="text-4xl font-bold">
                            <%
                                Connection con = null;
                                PreparedStatement ps = null;
                                ResultSet rs = null;
                                int totalUsers = 0;
                                try {
                                    con = db_connector.getConnection();
                                    String query = "SELECT COUNT(*) AS user_count FROM users";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    if (rs.next()) {
                                        totalUsers = rs.getInt("user_count");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) {
                                            rs.close();
                                        }
                                        if (ps != null) {
                                            ps.close();
                                        }
                                        if (con != null) {
                                            con.close();
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                out.print(totalUsers);
                            %>
                        </p>
                    </div>

                    <div class="bg-white p-5 rounded-lg shadow">
                        <h2 class="text-sm font-semibold text-gray-600">Ongoing Elections</h2>
                        <p class="text-4xl font-bold">
                            <%
                                int ongoingElections = 0;
                                try {
                                    con = db_connector.getConnection();
                                    String query = "SELECT COUNT(*) AS ongoing_count FROM elections WHERE start_date IS NOT NULL AND end_date IS NULL";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    if (rs.next()) {
                                        ongoingElections = rs.getInt("ongoing_count");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) {
                                            rs.close();
                                        }
                                        if (ps != null) {
                                            ps.close();
                                        }
                                        if (con != null) {
                                            con.close();
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                out.print(ongoingElections);
                            %>
                        </p>
                    </div>

                    <div class="bg-white p-5 rounded-lg shadow">
                        <h2 class="text-sm font-semibold text-gray-600">Registered Candidates</h2>
                        <p class="text-4xl font-bold">
                            <%
                                int candidateCount = 0;
                                try {
                                    con = db_connector.getConnection();
                                    String query = "SELECT COUNT(*) AS count FROM candidates";
                                    ps = con.prepareStatement(query);
                                    rs = ps.executeQuery();
                                    if (rs.next()) {
                                        candidateCount = rs.getInt("count");
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    try {
                                        if (rs != null) {
                                            rs.close();
                                        }
                                        if (ps != null) {
                                            ps.close();
                                        }
                                        if (con != null) {
                                            con.close();
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                                out.print(candidateCount);
                            %>
                        </p>
                    </div>

                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-lg font-bold">Calendar</h2>
                        <p class="mt-2 text-sm text-gray-500">Today</p>
                        <p class="text-lg font-semibold">
                            <%
                                java.util.Date today = new java.util.Date();
                                java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("MMMM dd, yyyy");
                                out.print(sdf.format(today));
                            %>
                        </p>
                    </div>
                </div>

                <!-- Election Management Section -->
                <div class="mt-8 bg-white p-6 rounded-lg shadow">
                    <h2 class="text-xl font-bold text-gray-800 mb-4">Election Management</h2>
                    <div class="overflow-x-auto">
                        <table class="min-w-full border-collapse border border-gray-300">
                            <thead>
                                <tr>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Election</th>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Status</th>
                                    <th class="border border-gray-300 p-3 bg-gray-50 text-left">Votes</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        con = db_connector.getConnection();
                                        String query = "SELECT e.election_id, e.`election name`, e.status, COUNT(v.vote_id) AS vote_count " +
                                                       "FROM elections e LEFT JOIN votes v ON e.election_id = v.election_id " +
                                                       "GROUP BY e.election_id, e.`election name`, e.status";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();

                                        while (rs.next()) {
                                            String electionName = rs.getString("election name");
                                            String status = rs.getString("status");
                                            int voteCount = rs.getInt("vote_count");
                                %>
                                <tr>
                                    <td class="border border-gray-300 p-3"><%= electionName %></td>
                                    <td class="border border-gray-300 p-3"><%= status %></td>
                                    <td class="border border-gray-300 p-3"><%= voteCount %></td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    } finally {
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        try {
                                            if (ps != null) {
                                                ps.close();
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
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    try {
                                        con = db_connector.getConnection();
                                        String query = "SELECT candidate_id, name, party_name, description FROM candidates";
                                        ps = con.prepareStatement(query);
                                        rs = ps.executeQuery();
                                        while (rs.next()) {
                                            String candidateName = rs.getString("name");
                                            String partyName = rs.getString("party_name");
                                            String description = rs.getString("description");
                                %>
                                <tr class="hover:bg-gray-50">
                                    <td class="border border-gray-300 p-3"><%= candidateName%></td>
                                    <td class="border border-gray-300 p-3"><%= partyName != null ? partyName : "Independent"%></td>
                                    <td class="border border-gray-300 p-3"><%= description != null ? description : "N/A"%></td>
                                </tr>
                                <%
                                        }
                                    } catch (SQLException e) {
                                        out.println("<tr><td colspan='3' class='border border-gray-300 p-3 text-center text-red-500'>Error loading data: " + e.getMessage() + "</td></tr>");
                                    } finally {
                                        try {
                                            if (rs != null) {
                                                rs.close();
                                            }
                                        } catch (SQLException e) {
                                            e.printStackTrace();
                                        }
                                        try {
                                            if (ps != null) {
                                                ps.close();
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
