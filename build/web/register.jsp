<%-- 
    Document   : register
    Created on : Jan 10, 2025, 7:47:56 PM
    Author     : NHT-Dilshan
--%>


<%@page import="classes.db_connector"%>
<%@page import="classes.user"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        String first_name = request.getParameter("first_name").trim();
        String last_name = request.getParameter("last_name").trim();
        String email = request.getParameter("email").trim();
        String password_hash = request.getParameter("password_hash");
        String role = "voter";

        // Basic validation
        if (first_name == null || first_name.isEmpty() || 
            last_name == null || last_name.isEmpty() || 
            email == null || email.isEmpty() || 
            password_hash == null || password_hash.isEmpty()) {
            response.sendRedirect("sign_up.jsp?s=3"); // Invalid input data
            return;
        }

        // Email format validation
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            response.sendRedirect("sign_up.jsp?s=5"); // Invalid email format
            return;
        }

        // Password length validation
        if (password_hash.length() < 6) {
            response.sendRedirect("sign_up.jsp?s=4"); // Password too short
            return;
        }

        user user = new user(first_name, last_name, email, password_hash, role);
        
        try {
            if (user.register(db_connector.getConnection())) {
                response.sendRedirect("sign_up.jsp?s=1"); // Success
            } else {
                response.sendRedirect("sign_up.jsp?s=2"); // Email already exists
            }
        } catch (Exception e) {
            response.sendRedirect("sign_up.jsp?s=0"); // Database error
        }
        
    } catch (Exception e) {
        response.sendRedirect("sign_up.jsp?s=0"); // General error
    }
%>