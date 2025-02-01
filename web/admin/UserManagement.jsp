<%@page import="java.sql.*, classes.db_connector"%>
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
    <script>
        let userIdToDelete = null;

        function openDeleteModal(userId) {
            userIdToDelete = userId; // Store the user ID to delete
            const modal = document.getElementById('deleteUserModal');
            modal.classList.remove('hidden');
        }

        function closeDeleteModal() {
            document.getElementById('deleteUserModal').classList.add('hidden');
            userIdToDelete = null; // Clear the stored user ID
        }

        function confirmDelete() {
            if (userIdToDelete) {
                const form = document.getElementById('delete-form');
                const input = document.createElement('input');
                input.type = 'hidden';
                input.name = 'userId';
                input.value = userIdToDelete;
                form.appendChild(input);
                form.submit(); // Submit the form to delete the user
            }
        }
    </script>
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
    <div class="w-full items-center p-4 md:p-8">
        <div class="max-w-7xl mx-auto p-6 bg-white rounded-lg shadow-lg">
            <header class="mb-6">
                <h1 class="text-3xl font-bold text-gray-800">Users Management</h1>
                <p class="text-gray-500">Manage and monitor Users</p>
            </header>

            <!-- User Management Section -->
            <div class="mt-8 bg-white p-6 rounded-lg shadow">
                <h2 class="text-xl font-bold text-gray-800 mb-4">Users List</h2>
                <table class="min-w-full border-collapse border border-gray-300">
                    <thead>
                        <tr>
                            <th class="border border-gray-300 p-3 bg-gray-50 text-left">Name</th>
                            <th class="border border-gray-300 p-3 bg-gray-50 text-left">Email</th>
                            <th class="border border-gray-300 p-3 bg-gray-50 text-left">Role</th>
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
                            String query = "SELECT user_id, first_name, last_name, email, role FROM users";
                            pst = con.prepareStatement(query);
                            rs = pst.executeQuery();

                            while (rs.next()) {
                                String fullName = rs.getString("first_name") + " " + rs.getString("last_name");
                                String email = rs.getString("email");
                                String role = rs.getString("role"); // Fetch the user role
                                int userId = rs.getInt("user_id");
                    %>
                        <tr class="hover:bg-gray-50">
                            <td class="border border-gray-300 p-3"><%= fullName %></td>
                            <td class="border border-gray-300 p-3"><%= email %></td>
                            <td class="border border-gray-300 p-3"><%= role %></td> <!-- Display the role -->
                            <td class="border border-gray-300 p-3">
                                <form action="UserDetails.jsp" method="get" class="inline-block">
                                    <input type="hidden" name="email" value="<%= email %>">
                                    <button type="submit" class="px-3 py-1 bg-yellow-500 text-white rounded">View</button>
                                </form>
                                <!-- Delete Button with modal -->
                                <button type="button" class="px-3 py-1 bg-red-500 text-white rounded hover:bg-red-600" onclick="openDeleteModal(<%= userId %>)">Delete</button>
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

    <!-- Delete User Confirmation Modal -->
    <div id="deleteUserModal" class="fixed inset-0 bg-gray-600 bg-opacity-50 flex items-center justify-center hidden">
        <div class="bg-white p-6 rounded-lg shadow-lg text-center">
            <h2 class="text-xl font-bold mb-4 text-gray-800">Confirm Deletion</h2>
            <p class="text-gray-600 mb-4">Are you sure you want to delete this user? This action cannot be undone.</p>
            <form id="delete-form" action="deleteUser.jsp" method="post" class="hidden">
                <!-- User ID will be added dynamically -->
            </form>
            <div class="flex justify-center space-x-4">
                <button onclick="confirmDelete()" class="bg-red-500 hover:bg-red-600 text-white px-4 py-2 rounded-md">Delete</button>
                <button onclick="closeDeleteModal()" class="bg-gray-300 hover:bg-gray-400 text-gray-700 px-4 py-2 rounded-md">Cancel</button>
            </div>
        </div>
    </div>

</body>
</html>
