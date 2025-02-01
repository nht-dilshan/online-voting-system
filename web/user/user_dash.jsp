<%@page import="java.text.SimpleDateFormat"%>
<%@page import="classes.db_connector"%>
<%@page import="classes.user"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%! user user = new user(); %>

<%
    // Ensure user is logged in
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("sign_in.jsp");
        return;
    }

    int user_id = (Integer) session.getAttribute("user_id");
    user.setUser_id(user_id);

    Connection conn = null;
    int votesUsed = 0;

    try {
        conn = db_connector.getConnection();
        user = user.getuserbyid(conn);

        // Query to count how many times the user has voted
        String voteCountQuery = "SELECT COUNT(*) FROM votes WHERE voter_id = ?";
        PreparedStatement voteStmt = conn.prepareStatement(voteCountQuery);
        voteStmt.setInt(1, user_id);
        ResultSet voteRs = voteStmt.executeQuery();

        if (voteRs.next()) {
            votesUsed = voteRs.getInt(1);
        }

        voteRs.close();
        voteStmt.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("sign_in.jsp");
        return;
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Dashboard</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>
</head>
<body class="flex flex-col md:flex-row h-screen bg-gray-100">

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
            <div class="px-6 py-3 bg-gray-300 cursor-pointer">
                <a href="user_dash.jsp" class="flex items-center text-gray-700">
                    <span class="ml-3">Home</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="votingArea.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Voting Area</span>
                </a>
            </div>
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="result.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
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
        <div class="w-full max-w-6xl mx-auto p-6 bg-white rounded-lg shadow-lg h-full overflow-auto">
            
            <!-- Display User Details -->
            <h1 class="text-3xl font-bold mb-4 text-gray-800">Hello, <%= user.getFirst_name() %> <%= user.getLast_name() %>!</h1>
            <p class="text-gray-500 mb-6">Welcome to VoteStream's Online Voting System</p>

            <!-- User Details Section -->
            <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
                <!-- Registration Date -->
                <div class="bg-white p-6 rounded-lg shadow">
                    <p class="text-sm font-semibold text-gray-600">Register Date</p>
                    <h2 class="text-4xl font-bold">
                        <%
                            if (user.getCreated_at() != null) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
                                out.print(sdf.format(user.getCreated_at()));
                            } else {
                                out.print("N/A");
                            }
                        %>
                    </h2>
                </div>

                <!-- Number of Votes Used -->
                <div class="bg-white p-6 rounded-lg shadow">
                    <p class="text-sm font-semibold text-gray-600">Number of votes used</p>
                    <h2 class="text-4xl font-bold"><%= votesUsed %></h2>
                </div>
            </div>

            <!-- Ongoing Election -->
            <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                <div class="bg-white p-6 rounded-lg shadow">
                    <%
                        String ongoingElectionName = "No Ongoing Election";
                        Connection con = null;
                        PreparedStatement ongoingPstmt = null;
                        ResultSet ongoingRs = null;

                        try {
                            con = db_connector.getConnection();
                            String ongoingQuery = "SELECT `election name` FROM elections WHERE status = 'Started' LIMIT 1";
                            ongoingPstmt = con.prepareStatement(ongoingQuery);
                            ongoingRs = ongoingPstmt.executeQuery();

                            if (ongoingRs.next()) {
                                ongoingElectionName = ongoingRs.getString("election name");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (ongoingRs != null) try { ongoingRs.close(); } catch (Exception ignore) {}
                            if (ongoingPstmt != null) try { ongoingPstmt.close(); } catch (Exception ignore) {}
                            if (con != null) try { con.close(); } catch (Exception ignore) {}
                        }
                    %>
                    <h2 class="text-lg font-bold"><%= ongoingElectionName %></h2>
                    <p class="text-sm text-gray-500">Ongoing Election</p>
                    <% if (!ongoingElectionName.equals("No Ongoing Election")) { %>
                        <a href="votingArea.jsp" class="mt-4 px-4 py-2 bg-emerald-500 text-white rounded-lg inline-block text-center">
                            Vote Now
                        </a>
                    <% } %>
                </div>

                <!-- Calendar -->
                <div class="bg-white p-6 rounded-lg shadow">
                    <h2 class="text-lg font-bold">Calendar</h2>
                    <p class="mt-2 text-sm text-gray-500">Today</p>
                    <p class="text-lg font-semibold"><%= new SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) %></p>
                </div>
            </div>
                 <!-- Election Activities Section -->
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6 mt-6">
                    <div class="bg-white p-6 rounded-lg shadow">
                        <h2 class="text-lg font-bold">Election Activities</h2>
                        <ul class="mt-2 space-y-2">
                            <%
                                // Fetch election data from the database
                                con = db_connector.getConnection();
                                String query = "SELECT `election name`, status FROM elections";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();
                                

                                while (rs.next()) {
                                    
                                    String electionName = rs.getString("election name");
                                    String status = rs.getString("status");
                            %>
                            <li class="flex justify-between">
                                <span><%= electionName %></span>
                                <span class="text-gray-500"><%= status %></span>
                            </li>
                            <%
                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            %>
                        </ul>
                    </div>
                </div>
        </div>
    </div>

</body>
</html>
