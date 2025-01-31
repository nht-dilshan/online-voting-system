<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
</head>
<body class="bg-gradient-to-br from-gray-100 to-gray-200 min-h-screen flex items-center justify-center font-inter">
    <div class="w-full max-w-md mx-auto bg-white p-8 rounded-xl shadow-2xl transform transition-all hover:scale-105 duration-300">
        <div class="text-center mb-6">
            <h1 class="text-3xl font-bold text-gray-800 mb-2">User Profile</h1>
            <p class="text-gray-500">Detailed user information</p>
        </div>
        <%
            String email = request.getParameter("email");
            String query = "SELECT first_name, last_name, email, role, created_at FROM users WHERE email = ?";
            Connection con = null;
            PreparedStatement pst = null;
            ResultSet rs = null;
            try {
                con = db_connector.getConnection();
                pst = con.prepareStatement(query);
                pst.setString(1, email);
                rs = pst.executeQuery();
                if (rs.next()) {
        %>
                    <div class="space-y-4">
                        <div class="bg-emerald-50 p-4 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-6 h-6 mr-3 text-emerald-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
                                </svg>
                                <span class="font-semibold text-gray-700">Name:</span>
                                <span class="ml-2 text-gray-600"><%= rs.getString("first_name") %> <%= rs.getString("last_name") %></span>
                            </div>
                        </div>
                        
                        <div class="bg-blue-50 p-4 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-6 h-6 mr-3 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"></path>
                                </svg>
                                <span class="font-semibold text-gray-700">Email:</span>
                                <span class="ml-2 text-gray-600"><%= rs.getString("email") %></span>
                            </div>
                        </div>
                        
                        <div class="bg-purple-50 p-4 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-6 h-6 mr-3 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4M7.835 4.697a3.42 3.42 0 001.946-.806 3.42 3.42 0 014.438 0 3.42 3.42 0 001.946.806 3.42 3.42 0 013.138 3.138 3.42 3.42 0 00.806 1.946 3.42 3.42 0 010 4.438 3.42 3.42 0 00-.806 1.946 3.42 3.42 0 01-3.138 3.138 3.42 3.42 0 00-1.946.806 3.42 3.42 0 01-4.438 0 3.42 3.42 0 00-1.946-.806 3.42 3.42 0 01-3.138-3.138 3.42 3.42 0 00-.806-1.946 3.42 3.42 0 010-4.438 3.42 3.42 0 00.806-1.946 3.42 3.42 0 013.138-3.138z"></path>
                                </svg>
                                <span class="font-semibold text-gray-700">Role:</span>
                                <span class="ml-2 text-gray-600"><%= rs.getString("role") %></span>
                            </div>
                        </div>
                        
                        <div class="bg-orange-50 p-4 rounded-lg">
                            <div class="flex items-center">
                                <svg class="w-6 h-6 mr-3 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                </svg>
                                <span class="font-semibold text-gray-700">Created At:</span>
                                <span class="ml-2 text-gray-600"><%= rs.getTimestamp("created_at") %></span>
                            </div>
                        </div>
                    </div>
        <%
                } else {
        %>
                    <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                        <strong class="font-bold">User Not Found</strong>
                        <span class="block sm:inline">No user exists with the provided email.</span>
                    </div>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
        %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative" role="alert">
                    <strong class="font-bold">Database Error</strong>
                    <span class="block sm:inline">An error occurred while fetching user details.</span>
                </div>
        <%
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
        
        <div class="mt-6 text-center">
            <a href="UserManagement.jsp" class="px-6 py-2 bg-emerald-500 text-white rounded-lg hover:bg-emerald-600 transition duration-300 inline-block">
                Back to User Management
            </a>
        </div>
    </div>
</body>
</html>