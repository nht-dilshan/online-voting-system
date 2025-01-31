<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@600&display=swap" rel="stylesheet">
    <style>
        .logo-font {
            font-family: 'Poppins', sans-serif;
        }
    </style>
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
      <div class="px-6 py-3 bg-gray-300 cursor-pointer">
          <a href="UserManagement.jsp" class="flex items-center text-gray-700">
          <span class="ml-3">Users Management</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="CandidateManagement.jsp" class="flex items-center text-gray-700">
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
  <div class=" w-full items-center p-4 md:p-8">
    <div class="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow-lg">
      
        <!-- Header Section -->
        <header class="mb-6">
            <h1 class="text-3xl font-bold text-gray-800">Users Management</h1>
            <p class="text-gray-500">Manage and monitor Users</p>
        </header>

        <!-- Voter Management Section -->
        <div class="mt-8 bg-white p-6 rounded-lg shadow">
            <h2 class="text-xl font-bold text-gray-800 mb-4">Users List</h2>
            <table class="min-w-full border-collapse border border-gray-300">
                <thead>
                    <tr>
                        <th class="border border-gray-300 p-3 bg-gray-50 text-left">Name</th>
                        <th class="border border-gray-300 p-3 bg-gray-50 text-left">Email</th>
                        <th class="border border-gray-300 p-3 bg-gray-50 text-left">Actions</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    Connection con = null;
                    PreparedStatement pst = null;
                    ResultSet rs = null;
                    try {
                        con = db_connector.getConnection();
                        String query = "SELECT first_name, last_name, email FROM users";
                        pst = con.prepareStatement(query);
                        rs = pst.executeQuery();

                        while (rs.next()) {
                            String fullName = rs.getString("first_name") + " " + rs.getString("last_name");
                            String email = rs.getString("email");
                %>
                    <tr class="hover:bg-gray-50">
                        <td class="border border-gray-300 p-3"><%= fullName %></td>
                        <td class="border border-gray-300 p-3"><%= email %></td>
                        <td class="border border-gray-300 p-3">
                            <form action="UserDetails.jsp" method="get">
                                <input type="hidden" name="email" value="<%= email %>">
                                <button type="submit" class="px-3 py-1 bg-yellow-500 text-white rounded">View</button>
                            </form>
                        </td>
                    </tr>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        try {
                            if (rs != null) rs.close();
                            if (pst != null) pst.close();
                            if (con != null) con.close();
                        } catch (SQLException e) {
                            e.printStackTrace();
                        }
                    }
                %>
                </tbody>
            </table>
        </div>

        <!-- Footer -->
        <footer class="mt-8 text-center text-gray-500">
            &copy; 2025 Voting System. All rights reserved.
        </footer>
    </div>
  </div>
</body>
</html>
