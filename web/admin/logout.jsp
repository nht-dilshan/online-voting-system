<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body class="flex items-center justify-center h-screen bg-gray-100">

    <!-- Logout Confirmation Modal -->
    <div id="logoutModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center">
        <div class="bg-white p-6 rounded-lg shadow-lg text-center">
            <h2 class="text-xl font-bold mb-4 text-gray-800">Confirm Logout</h2>
            <p class="text-gray-600 mb-4">Are you sure you want to log out?</p>
            <div class="flex justify-center space-x-4">
                <form method="post">
                    <button type="submit" name="confirmLogout"
                        class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-md">
                        Logout
                    </button>
                </form>
                <button id="cancelLogout"
                    class="bg-gray-300 hover:bg-gray-400 text-gray-700 px-4 py-2 rounded-md">
                    Cancel
                </button>
            </div>
        </div>
    </div>

    <script>
        // Hide modal if "Cancel" is clicked
        $("#cancelLogout").click(function () {
            window.location.href = "admin_dash.jsp"; // Redirect to dashboard or home page
        });
    </script>

</body>
</html>

<%
    // Handle logout only if the form is submitted
    if (request.getParameter("confirmLogout") != null) {
        HttpSession userSession = request.getSession(false);
        if (userSession != null) {
            userSession.invalidate(); // Destroy session
        }
        response.sendRedirect("../index.jsp"); // Redirect to the home page after logout
    }
%>
