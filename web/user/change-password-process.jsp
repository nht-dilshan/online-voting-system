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
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

  <div class="w-full max-w-2xl bg-white shadow-2xl rounded-xl overflow-hidden">
    <div class="bg-emerald-600 text-white p-6">
        <h1 class="text-3xl font-bold">Change Password</h1>
    </div>

    <div class="p-8">
        <%
            String message = (String) request.getAttribute("message");
            String messageType = "";
            if (message != null) {
                messageType = message.contains("successfully") ? "success" : "error";
        %>
        <!-- Display the message using SweetAlert -->
        <script>
            Swal.fire({
                icon: '<%= messageType %>',
                title: '<%= messageType.equals("success") ? "Success!" : "Error" %>',
                text: '<%= message %>',
                confirmButtonColor: '<%= messageType.equals("success") ? "#10B981" : "#EF4444" %>'
            });
        </script>
        <% } %>

        <!-- Change Password Form -->
        <form action="change-password-process.jsp" method="post" class="space-y-6">
            <div>
                <label for="currentPassword" class="block text-gray-700 font-medium">Current Password:</label>
                <input type="password" id="currentPassword" name="currentPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
            </div>

            <div>
                <label for="newPassword" class="block text-gray-700 font-medium">New Password:</label>
                <input type="password" id="newPassword" name="newPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
            </div>

            <div>
                <label for="confirmPassword" class="block text-gray-700 font-medium">Confirm Password:</label>
                <input type="password" id="confirmPassword" name="confirmPassword" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
            </div>

            <div class="flex justify-between items-center">
                <a href="profile.jsp" class="text-emerald-600 hover:underline">Back to Profile</a>
                <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Change Password</button>
            </div>
        </form>
    </div>
  </div>

</body>
</html>
