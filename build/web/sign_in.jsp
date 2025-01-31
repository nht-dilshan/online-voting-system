<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.db_connector"%>
<%@page import="java.sql.*"%>
<%@page import="classes.user" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign In</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    </head>
    <body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-emerald-800 to-gray-700 relative">
        <!-- Background diagonal stripes -->
        <div class="absolute inset-0 overflow-hidden">
            <div class="absolute top-0 right-0 w-1/2 h-full bg-emerald-700 transform skew-x-12"></div>
            <div class="absolute bottom-0 left-0 w-1/2 h-full bg-gray-600 transform -skew-x-12"></div>
        </div>

        <!-- Card Container -->
        <div class="relative w-full max-w-md mx-4">
            <!-- Sign In Card -->
            <div class="bg-white rounded-xl shadow-xl p-8">
                <!-- Logo/Title -->
                <h1 class="text-emerald-500 text-3xl font-bold text-center mb-2">
                    VoteStream
                </h1>

                <!-- Subtitle -->
                <p class="text-gray-600 text-center mb-4">
                    Sign in to cast your vote for who you believe in.
                </p>

                <!-- Error Message Display -->
                <%
                    String status = request.getParameter("s");
                    String errorMessage = "";
                    if ("1".equals(status)) {
                        errorMessage = "Email and Password are required.";
                    } else if ("2".equals(status)) {
                        errorMessage = "Database connection error. Please try again later.";
                    } else if ("3".equals(status)) {
                        errorMessage = "Invalid email or password. Please try again.";
                    } else if ("4".equals(status)) {
                        errorMessage = "System error. Please contact support.";
                    }
                    
                    if (!errorMessage.isEmpty()) {
                %>
                <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4" role="alert">
                     <%= errorMessage %>
                </div>
                <% } %>

                <!-- Form -->
                <form class="space-y-6" action="login.jsp" method="POST">
                    <!-- Email Field -->
                    <div class="space-y-2">
                        <label for="email" class="block text-gray-600 text-sm font-medium">
                            Email address
                        </label>
                        <input
                            type="email"
                            id="email"
                            name="email"
                            required
                            placeholder="Enter Email address"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                        />
                    </div>

                    <!-- Password Field -->
                    <div class="space-y-2">
                        <label for="password" class="block text-gray-600 text-sm font-medium">
                            Password
                        </label>
                        <div class="relative">
                            <input
                                type="password"
                                id="password"
                                name="password_hash"
                                required
                                placeholder="Enter password"
                                class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            />
                            <button
                                type="button"
                                onclick="togglePasswordVisibility()"
                                class="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600"
                            >
                                <span id="password-icon" class="material-icons">visibility</span>
                            </button>
                        </div>
                    </div>

                    <!-- Sign In Button -->
                    <button
                        type="submit"
                        class="w-full bg-emerald-500 text-white py-2 rounded-md hover:bg-emerald-600 transition-colors duration-200"  
                    >
                        Sign in
                    </button>

                    <!-- Sign Up Link -->
                    <div class="text-center text-sm">
                        <span class="text-gray-600">Don't have an account? </span>
                        <a href="sign_up.jsp" class="text-emerald-500 hover:text-emerald-600">
                            Sign up
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function togglePasswordVisibility() {
                const passwordInput = document.getElementById('password');
                const passwordIcon = document.getElementById('password-icon');
                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    passwordIcon.textContent = 'visibility_off';
                } else {
                    passwordInput.type = 'password';
                    passwordIcon.textContent = 'visibility';
                }
            }
        </script>
    </body>
</html>
