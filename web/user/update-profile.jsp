<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*, classes.db_connector"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Update Profile</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="bg-gray-50 min-h-screen flex items-center justify-center">

  <div class="w-full max-w-2xl bg-white shadow-2xl rounded-xl overflow-hidden">
    <div class="bg-emerald-600 text-white p-6">
      <h1 class="text-3xl font-bold">Update Profile</h1>
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

      <!-- Update Profile Form -->
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
              String query = "SELECT first_name, last_name, email FROM users WHERE user_id = ?";
              ps = con.prepareStatement(query);
              ps.setInt(1, user_id); // Use the logged-in user's ID from the session
              rs = ps.executeQuery();

              if (rs != null && rs.next()) {
                  String firstName = rs.getString("first_name");
                  String lastName = rs.getString("last_name");
                  String email = rs.getString("email");
        %>

        <form action="update-profile-process.jsp" method="post" class="space-y-6">
          <!-- First Name Field -->
          <div>
            <label for="firstName" class="block text-gray-700 font-medium">First Name:</label>
            <input type="text" id="firstName" name="firstName" value="<%= firstName %>" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>

          <!-- Last Name Field -->
          <div>
            <label for="lastName" class="block text-gray-700 font-medium">Last Name:</label>
            <input type="text" id="lastName" name="lastName" value="<%= lastName %>" class="w-full px-4 py-2 border border-gray-300 rounded-md" required>
          </div>

          <!-- Email Field (Read-only) -->
          <div>
            <label for="email" class="block text-gray-700 font-medium">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>" class="w-full px-4 py-2 border border-gray-300 rounded-md bg-gray-100 cursor-not-allowed" readonly>
          </div>

          <!-- Action Buttons -->
          <div class="flex justify-between items-center">
            <a href="profile.jsp" class="text-emerald-600 hover:underline">Back to Profile</a>
            <button type="submit" class="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600">Update Profile</button>
          </div>
        </form>
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
    </div>
  </div>

</body>
</html>
