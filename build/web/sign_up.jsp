<%-- 
    Document   : sign_up
    Created on : Jan 6, 2025, 11:47:35 PM
    Author     : NHT-Dilshan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="classes.db_connector"%>
<%@page import="java.sql.*"%>
<%@page import="classes.user" %>
<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Sign Up - VoteStream</title>
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
        <div class="relative z-10 w-full max-w-md bg-white rounded-xl shadow-2xl p-8">
            <!-- Sign Up Card -->
            <div class="w-full">
                <!-- Logo/Title -->
                <h1 class="text-emerald-500 text-4xl font-bold text-center mb-4">
                    VoteStream
                </h1>

                <!-- Message Display -->
                <%
                    String message = "";
                    if (request.getParameter("s") != null) {
                        String status = request.getParameter("s");
                        if (status.equals("1")) {
                            message = "<p class='text-green-500 text-center mb-4'>You have successfully registered.</p>";
                        } else if (status.equals("2")) {
                            message = "<p class='text-red-500 text-center mb-4'>This email is already registered. Please use a different email address.</p>";
                        } else if (status.equals("3")) {
                            message = "<p class='text-red-500 text-center mb-4'>Invalid input data. Please check your details.</p>";
                        } else if (status.equals("4")) {
                            message = "<p class='text-red-500 text-center mb-4'>Password must be at least 6 characters long.</p>";
                        } else if (status.equals("5")) {
                            message = "<p class='text-red-500 text-center mb-4'>Invalid email format.</p>";
                        } else {
                            message = "<p class='text-red-500 text-center mb-4'>An error occurred. Please try again.</p>";
                        }
                    }
                %>

                <!-- Subtitle -->
                <p class="text-gray-500 text-center mb-6">
                    Join us and start your journey today.
                </p>

                <%= message%>

                <!-- Form -->
                <form method="POST" action="register.jsp" class="space-y-6" onsubmit="return validateForm()">
                    <!-- First Name Field -->
                    <div class="space-y-1">
                        <label class="block text-gray-600 text-sm font-medium">
                            First name
                        </label>
                        <input
                            type="text"
                            name="first_name"
                            id="firstNameInput"
                            placeholder="Enter your first name"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            required
                            />
                    </div>

                    <!-- Last Name Field -->
                    <div class="space-y-1">
                        <label class="block text-gray-600 text-sm font-medium">
                            Last name
                        </label>
                        <input
                            type="text"
                            name="last_name"
                            id="lastNameInput"
                            placeholder="Enter your last name"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            required
                            />
                    </div>

                    <!-- Email Field -->
                    <div class="space-y-1">
                        <label class="block text-gray-600 text-sm font-medium">
                            Email address
                        </label>
                        <input
                            type="email"
                            name="email"
                            id="emailInput"
                            placeholder="Enter your email"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            required
                            />
                    </div>

                    <!-- Password Field -->
                    <div class="space-y-1 relative">
                        <label class="block text-gray-600 text-sm font-medium">
                            Password
                        </label>
                        <input
                            type="password"
                            name="password_hash"
                            id="passwordInput"
                            placeholder="Enter your password"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            required
                            />
                        <button
                            type="button"
                            onclick="togglePasswordVisibility('passwordInput', 'password-icon')"
                            class="absolute right-3 top-2/3 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
                            >
                            <span id="password-icon" class="material-icons">visibility</span>
                        </button>
                    </div>

                    <!-- Confirm Password Field -->
                    <div class="space-y-1 relative">
                        <label class="block text-gray-600 text-sm font-medium">
                            Confirm Password
                        </label>
                        <input
                            type="password"
                            name="confirmPassword"
                            id="confirmPasswordInput"
                            placeholder="Re-enter your password"
                            class="w-full px-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-emerald-500"
                            required
                            />
                        <button
                            type="button"
                            onclick="togglePasswordVisibility('confirmPasswordInput', 'confirmPassword-icon')"
                            class="absolute right-3 top-2/3 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
                            >
                            <span id="confirmPassword-icon" class="material-icons">visibility</span>
                        </button>
                    </div>

                    <!-- Sign Up Button -->
                    <button
                        type="submit"
                        class="w-full bg-emerald-500 text-white py-3 rounded-lg text-lg font-semibold hover:bg-emerald-600 transition-colors duration-300"
                        >
                        Sign up
                    </button>

                    <!-- Already Have an Account -->
                    <div class="text-center text-sm">
                        <span class="text-gray-500">Already have an account? </span>
                        <a href="login.jsp" class="text-emerald-500 hover:text-emerald-600">
                            Sign in
                        </a>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function togglePasswordVisibility(fieldId, iconId) {
                const passwordInput = document.getElementById(fieldId);
                const passwordIcon = document.getElementById(iconId);

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
//                    passwordIcon.textContent = 'visibility_off';
                } else {
                    passwordInput.type = 'password';
//                    passwordIcon.textContent = 'visibility';
                }
            }

            function validateForm() {
                const password = document.getElementById('passwordInput').value;
                const confirmPassword = document.getElementById('confirmPasswordInput').value;

                if (password !== confirmPassword) {
                    alert('Passwords do not match!');
                    return false;
                }

                return true;
            }
        </script>
    </body>
</html>