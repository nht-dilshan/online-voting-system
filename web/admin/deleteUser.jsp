<%@page import="java.sql.*, classes.db_connector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String userIdParam = request.getParameter("userId");
    if (userIdParam != null && !userIdParam.isEmpty()) {
        int userId = Integer.parseInt(userIdParam);

        Connection con = null;
        PreparedStatement pst = null;

        try {
            con = db_connector.getConnection();
            String deleteQuery = "DELETE FROM users WHERE user_id = ?";
            pst = con.prepareStatement(deleteQuery);
            pst.setInt(1, userId);
            int rowsAffected = pst.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("UserManagement.jsp"); // Redirect back to user management page after deletion
            } else {
                out.println("Error: User not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        out.println("Error: No user ID provided.");
    }
%>
