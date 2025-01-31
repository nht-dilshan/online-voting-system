<%@page import="classes.db_connector"%>
<%@page import="classes.user"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    try {
        // Get parameters with null checking
        String email = request.getParameter("email");
        String password_hash = request.getParameter("password_hash");
        
        // Validate parameters
        if (email == null || password_hash == null || email.trim().isEmpty() || password_hash.trim().isEmpty()) {
            System.out.println("Login attempt failed: Missing email or password");
            response.sendRedirect("sign_in.jsp?s=1"); // 1 = missing parameters
            return;
        }
        
        // Establish database connection
        java.sql.Connection conn = db_connector.getConnection();
        if (conn == null) {
            System.out.println("Login attempt failed: Database connection error");
            response.sendRedirect("sign_in.jsp?s=2"); // 2 = database error
            return;
        }
        
        // Create user object and authenticate
        user user = new user(email.trim(), password_hash.trim());
        if (user.authenticate(conn)) {
            // Successful login
            session.setAttribute("user_id", user.getUser_id());
            
            // Check user role and redirect accordingly
            if ("admin".equals(user.getRole())) {
                response.sendRedirect("admin/admin_dash.jsp");
            } else {
                response.sendRedirect("user/user_dash.jsp");
            }
        } else {
            System.out.println("Login failed for email: " + email);
            response.sendRedirect("sign_in.jsp?s=3"); // 3 = invalid credentials
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("sign_in.jsp?s=4"); // 4 = system error
    }
%>
