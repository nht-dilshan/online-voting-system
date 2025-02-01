<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Profile</title>
  <script src="https://cdn.tailwindcss.com"></script>
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
    <div class="container mx-auto h-full">
      <!-- Page Title -->
      <h1 class="text-2xl font-bold mb-6 text-gray-800">Profile</h1>

      <!-- Profile Card -->
      <div class="bg-white shadow-md rounded-lg p-8">
        <%
          // Fetch user details from the database
          Connection con = null;
          PreparedStatement ps = null;
          ResultSet rs = null;

          try {
              // Get the user_id from the session
              Integer user_id = (Integer) session.getAttribute("user_id");

              if (user_id == null) {
                  // Redirect to login page if user is not logged in
                  response.sendRedirect("../sign_in.jsp");
                  return;
              }

              con = db_connector.getConnection();
              String query = "SELECT first_name, last_name, email, created_at, updated_at FROM users WHERE user_id = ?";
              ps = con.prepareStatement(query);
              ps.setInt(1, user_id); // Use the logged-in user's ID from the session
              rs = ps.executeQuery();

              if (rs != null && rs.next()) {
                  String firstName = rs.getString("first_name");
                  String lastName = rs.getString("last_name");
                  String email = rs.getString("email");
                  String createdAt = rs.getString("created_at");
                  String updatedAt = rs.getString("updated_at");
        %>
        <div>
          <h2 class="text-xl font-semibold text-gray-800"><%= firstName %> <%= lastName %></h2>
          <p class="text-gray-600"><%= email %></p>
          <p class="text-gray-600">Member since: <%= createdAt %></p>
          <p class="text-gray-600">Last updated: <%= updatedAt %></p>
        </div>
        <div class="mt-8">
          <h2 class="text-lg font-medium text-gray-800 mb-4">Personal Information</h2>
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <p class="text-gray-600"><span class="font-medium">First Name:</span> <%= firstName %></p>
            </div>
            <div>
              <p class="text-gray-600"><span class="font-medium">Last Name:</span> <%= lastName %></p>
            </div>
            <div>
              <p class="text-gray-600"><span class="font-medium">Email:</span> <%= email %></p>
            </div>
            <div>
              <p class="text-gray-600"><span class="font-medium">Account Created:</span> <%= createdAt %></p>
            </div>
          </div>
        </div>
        <%
              } else {
                  out.println("<p class='text-red-500'>No user data found.</p>");
              }
          } catch (SQLException e) {
              e.printStackTrace();
              out.println("<p class='text-red-500'>Error fetching user data: " + e.getMessage() + "</p>");
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

      <!-- Settings Section -->
      <div class="mt-8 bg-white shadow-md rounded-lg p-8">
        <h2 class="text-xl font-semibold text-gray-800 mb-4">Account Settings</h2>
        <div class="space-y-4">
          <a href="update-profile.jsp" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600 inline-block">
            Update Profile
          </a>
          <a href="change-password-process.jsp" class="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600 inline-block">
            Change Password
          </a>
        </div>
      </div>
    </div>
  </div>
</body>
</html>