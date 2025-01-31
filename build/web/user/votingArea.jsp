<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>

<%
    // Ensure user is logged in
    Integer userId = (Integer) session.getAttribute("user_id");
    if (userId == null) {
        response.sendRedirect("sign_in.jsp?s=3");
        return;
    }

    boolean hasVotedInCurrentElection = false;
    int currentElectionId = -1;
    String electionName = "Ongoing Election";

    Connection conn = null;
    PreparedStatement electionStmt = null, checkVoteStmt = null;
    ResultSet electionRs = null, voteRs = null;

    try {
        conn = db_connector.getConnection();

        // Get the current ongoing election
        String electionQuery = "SELECT election_id, `election name` FROM elections WHERE status = 'Started' LIMIT 1";
        electionStmt = conn.prepareStatement(electionQuery);
        electionRs = electionStmt.executeQuery();

        if (electionRs.next()) {
            currentElectionId = electionRs.getInt("election_id");
            electionName = electionRs.getString("election name");
        }

        // Check if the user has already voted in the current election
        if (currentElectionId != -1) {
            String checkVoteQuery = "SELECT COUNT(*) FROM votes WHERE voter_id = ? AND election_id = ?";
            checkVoteStmt = conn.prepareStatement(checkVoteQuery);
            checkVoteStmt.setInt(1, userId);
            checkVoteStmt.setInt(2, currentElectionId);
            voteRs = checkVoteStmt.executeQuery();

            if (voteRs.next() && voteRs.getInt(1) > 0) {
                hasVotedInCurrentElection = true;
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (voteRs != null) try { voteRs.close(); } catch (SQLException ignore) {}
        if (checkVoteStmt != null) try { checkVoteStmt.close(); } catch (SQLException ignore) {}
        if (electionRs != null) try { electionRs.close(); } catch (SQLException ignore) {}
        if (electionStmt != null) try { electionStmt.close(); } catch (SQLException ignore) {}
        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Poll</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
            <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
                <a href="user_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
                    <span class="ml-3">Home</span>
                </a>
            </div>
            <div class="px-6 py-3 bg-gray-300 cursor-pointer">
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
            <h1 class="text-2xl font-bold mb-6"><%= electionName %></h1>
            <% if (hasVotedInCurrentElection) { %>
                <span class="text-red-500 text-lg font-semibold">You already voted</span>
            <% } %>
            <div class="bg-white shadow-md rounded-lg overflow-hidden">
                <div class="px-6 py-4">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-gray-200">
                                <th class="py-2 px-4 text-left">Name</th>
                                <th class="py-2 px-4 text-left">Description</th>
                                <th class="py-2 px-4 text-left">Party Name</th>
                                <% if (!hasVotedInCurrentElection) { %> 
                                    <th class="py-2 px-4 text-left" id="actionColumn">Action</th>
                                <% } %>
                            </tr>
                        </thead>
                        <tbody id="aspirantsTable">
                            <%
                                Connection candidateConn = db_connector.getConnection();
                                PreparedStatement candidateStmt = null;
                                ResultSet candidateRs = null;

                                try {
                                    String candidateQuery = "SELECT c.candidate_id, c.name, c.party_name, c.description " +
                                                            "FROM candidates c " +
                                                            "WHERE c.election_id = ?";
                                    candidateStmt = candidateConn.prepareStatement(candidateQuery);
                                    candidateStmt.setInt(1, currentElectionId);
                                    candidateRs = candidateStmt.executeQuery();

                                    while (candidateRs.next()) {
                            %>
                            <tr>
                                <td class="py-2 px-4 border-b"><%= candidateRs.getString("name") %></td>
                                <td class="py-2 px-4 border-b"><%= candidateRs.getString("description") %></td>
                                <td class="py-2 px-4 border-b"><%= candidateRs.getString("party_name") %></td>
                                <% if (!hasVotedInCurrentElection) { %>
                                <td class="py-2 px-4 border-b">
                                    <button class="vote-button bg-green-500 hover:bg-green-600 text-white px-4 py-2 rounded-md"
                                            data-candidate-id="<%= candidateRs.getInt("candidate_id") %>">
                                        Vote
                                    </button>
                                </td>
                                <% } %>
                            </tr>
                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Confirmation -->
    <div id="voteModal" class="hidden fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg shadow-lg">
            <h2 class="text-lg font-bold mb-4">Confirm Your Vote</h2>
            <p id="modalText"></p>
            <div class="mt-4 flex justify-end">
                <button id="confirmVote" class="bg-green-500 text-white px-4 py-2 rounded-md mr-2">Confirm</button>
                <button id="cancelVote" class="bg-gray-400 text-white px-4 py-2 rounded-md">Cancel</button>
            </div>
        </div>
    </div>

    <!-- JavaScript for Voting -->
    <script>
        var selectedCandidateId = null;

        $(".vote-button").click(function () {
            selectedCandidateId = $(this).attr("data-candidate-id");
            $("#modalText").text("Are you sure you want to vote for this candidate?");
            $("#voteModal").removeClass("hidden");
        });

        $("#confirmVote").click(function () {
            $.post("vote.jsp", { 
                voter_id: "<%= userId %>", 
                candidate_id: selectedCandidateId 
            }, function (response) {
                $("#voteModal").addClass("hidden");
                if (response.trim() === "success") {
                    location.reload();
                }
            });
        });

        $("#cancelVote").click(function () {
            $("#voteModal").addClass("hidden");
        });
    </script>
</body>
</html>
