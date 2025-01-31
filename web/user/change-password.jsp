<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Change Password</title>
  <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="h-screen flex bg-gray-100 font-sans">

  <!-- Sidebar -->
  <div class="bg-white shadow-lg h-full w-64 fixed flex flex-col">
    <div class="p-6">
        <a href="../index.jsp" class="font-bold text-lg text-emerald-500">VoteStream</a>
    </div>
    <nav class="mt-6 flex-grow">
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="user_dash.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Home</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="poll.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Poll</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="result.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">Results</span>
        </a>
      </div>
      <div class="px-6 py-3 bg-gray-300 cursor-pointer">
          <a href="profile.jsp" class="flex items-center text-gray-700">
          <span class="ml-3">Profile</span>
        </a>
      </div>
      <div class="px-6 py-3 hover:bg-gray-300 cursor-pointer">
          <a href="userAbout.jsp" class="flex items-center text-gray-700 hover:text-emerald-500">
          <span class="ml-3">About Us</span>
        </a>
      </div>
      <div class="px-6 py-3 mt-auto cursor-pointer">
        <form action="../logout.jsp" method="post">
          <button type="submit" class="w-full bg-red-500 text-white py-2 rounded hover:bg-red-600">Logout</button>
        </form>
      </div>
    </nav>
  </div>

  <!-- Main Content -->
  <div class="ml-64 flex-grow overflow-auto p-6">
    <div class="container mx-auto h-full">
      <!-- Page Title -->
      <h1 class="text-2xl font-bold mb-6 text-gray-800">Change Password</h1>

      <!-- Display Messages -->
      <%
        String message = (String) request.getAttribute("message");
        if (message != null) {
            String messageClass = message.contains("successfully") ? "text-green-500" : "text-red-500";
      %>
      <div class="mb-6">
        <p class="<%= messageClass %>"><%= message %></p>
      </div>
      <%
        }
      %>

      <!-- Change Password Form -->
      <div class="bg-white shadow-md rounded-lg p-8">
        <form action="change-password-process.jsp" method="post" class="space-y-6">
          <div>
            <label for="email" class="block text-gray-700 font-medium">Email:</label>
            <input type="email" id="email" name="email" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>
          <div>
            <label for="firstName" class="block text-gray-700 font-medium">First Name:</label>
            <input type="text" id="firstName" name="firstName" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>
          <div>
            <label for="newPassword" class="block text-gray-700 font-medium">New Password:</label>
            <input type="password" id="newPassword" name="newPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>
          <div>
            <label for="confirmPassword" class="block text-gray-700 font-medium">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="confirmPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>
          <div class="flex justify-between">
            <a href="profile.jsp" class="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-600">Back</a>
            <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Change Password</button>
          </div>
        </form>
      </div>
    </div>
  </div>
</body>
</html>