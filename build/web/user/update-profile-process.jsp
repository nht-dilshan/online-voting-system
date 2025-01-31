<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="classes.db_connector"%>
<%
    // Get the current user's ID from the session
    Integer user_id = (Integer) session.getAttribute("user_id");

    if (user_id == null) {
        // Redirect to login page if the user is not logged in
        response.sendRedirect("../sign_in.jsp");
        return;
    }

    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    String message = "";

    if (firstName != null && lastName != null && email != null) {
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = db_connector.getConnection();
            String query = "UPDATE users SET first_name = ?, last_name = ?, email = ? WHERE user_id = ?";
            ps = con.prepareStatement(query);
            ps.setString(1, firstName);
            ps.setString(2, lastName);
            ps.setString(3, email);
            ps.setInt(4, user_id); // Use the logged-in user's ID from the session

            int result = ps.executeUpdate();
            if (result > 0) {
                message = "Profile updated successfully!";
            } else {
                message = "Failed to update profile. Please try again.";
            }
        } catch (SQLException e) {
            e.printStackTrace();
            message = "An error occurred: " + e.getMessage();
        } finally {
            try {
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        message = "Invalid data provided. Please try again.";
    }

    // Set the message as a request attribute
    request.setAttribute("message", message);

    // Forward the request back to update-profile.jsp
    request.getRequestDispatcher("update-profile.jsp").forward(request, response);
%>