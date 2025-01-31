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
                response.sendRedirect("UserManagement.jsp?message=User deleted successfully"); // Redirect back to user management page after deletion
            } else {
                response.sendRedirect("UserManagement.jsp?error=User not found");
            }
        } catch (SQLException e) {
            response.sendRedirect("UserManagement.jsp?error=Database error: " + e.getMessage());
        } finally {
            try {
                if (pst != null) pst.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    } else {
        response.sendRedirect("UserManagement.jsp?error=No user ID provided");
    }
%>