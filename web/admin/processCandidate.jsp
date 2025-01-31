<%@page import="java.sql.Connection"%>
<%@page import="classes.db_connector"%>
<%@page import="classes.candidate"%>
<%
    String name = request.getParameter("name");
    String partyName = request.getParameter("party_name");
    String description = request.getParameter("description");
    String status = "";

    if (name != null && partyName != null && description != null) {
        Connection con = db_connector.getConnection();
        if (con != null) {
            candidate cand = new candidate(name, partyName, description);
            if (cand.register(con)) {
                status = "1"; // Registration successful
            } else {
                status = "2"; // Registration failed
            }
        } else {
            status = "0"; // Database connection failed
        }
    } else {
        status = "3"; // Missing required fields
    }

    response.sendRedirect("addCandidate.jsp?status=" + status);
%>
