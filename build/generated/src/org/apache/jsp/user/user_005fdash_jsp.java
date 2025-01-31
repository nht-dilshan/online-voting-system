package org.apache.jsp.user;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.text.SimpleDateFormat;
import classes.db_connector;
import classes.user;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public final class user_005fdash_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

 user user = new user(); 
  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write('\n');
      out.write('\n');

    // Ensure user is logged in
    if (session.getAttribute("user_id") == null) {
        response.sendRedirect("sign_in.jsp");
        return;
    }

    int user_id = (Integer) session.getAttribute("user_id");
    user.setUser_id(user_id);

    Connection conn = null;
    int votesUsed = 0;

    try {
        conn = db_connector.getConnection();
        user = user.getuserbyid(conn);

        // Query to count how many times the user has voted
        String voteCountQuery = "SELECT COUNT(*) FROM votes WHERE voter_id = ?";
        PreparedStatement voteStmt = conn.prepareStatement(voteCountQuery);
        voteStmt.setInt(1, user_id);
        ResultSet voteRs = voteStmt.executeQuery();

        if (voteRs.next()) {
            votesUsed = voteRs.getInt(1);
        }

        voteRs.close();
        voteStmt.close();

    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("sign_in.jsp");
        return;
    } finally {
        if (conn != null) try { conn.close(); } catch (Exception ignore) {}
    }

      out.write("\n");
      out.write("\n");
      out.write("<!DOCTYPE html>\n");
      out.write("<html lang=\"en\">\n");
      out.write("<head>\n");
      out.write("    <meta charset=\"UTF-8\">\n");
      out.write("    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");
      out.write("    <title>User Dashboard</title>\n");
      out.write("    <script src=\"https://cdn.tailwindcss.com\"></script>\n");
      out.write("</head>\n");
      out.write("<body class=\"flex flex-col md:flex-row h-screen bg-white\">\n");
      out.write("\n");
      out.write("    <!-- Sidebar -->\n");
      out.write("    <div class=\"bg-emerald-500 shadow-lg h-full w-full md:w-64 fixed md:relative flex flex-col\">\n");
      out.write("        <div class=\"p-6\">\n");
      out.write("            <a href=\"../index.jsp\" class=\"font-bold text-lg text-white\">VoteStream</a>\n");
      out.write("        </div>\n");
      out.write("        <nav class=\"mt-6 flex-grow\">\n");
      out.write("            <div class=\"px-6 py-3 bg-emerald-600 cursor-pointer\">\n");
      out.write("                <a href=\"user_dash.jsp\" class=\"flex items-center text-white\">\n");
      out.write("                    <span class=\"ml-3\">Home</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"px-6 py-3 hover:bg-emerald-600 cursor-pointer\">\n");
      out.write("                <a href=\"votingArea.jsp\" class=\"flex items-center text-white hover:text-gray-200\">\n");
      out.write("                    <span class=\"ml-3\">Voting Area</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"px-6 py-3 hover:bg-emerald-600 cursor-pointer\">\n");
      out.write("                <a href=\"result.jsp\" class=\"flex items-center text-white hover:text-gray-200\">\n");
      out.write("                    <span class=\"ml-3\">Results</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"px-6 py-3 hover:bg-emerald-600 cursor-pointer\">\n");
      out.write("                <a href=\"profile.jsp\" class=\"flex items-center text-white hover:text-gray-200\">\n");
      out.write("                    <span class=\"ml-3\">Profile</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"px-6 py-3 hover:bg-emerald-600 cursor-pointer\">\n");
      out.write("                <a href=\"userAbout.jsp\" class=\"flex items-center text-white hover:text-gray-200\">\n");
      out.write("                    <span class=\"ml-3\">About Us</span>\n");
      out.write("                </a>\n");
      out.write("            </div>\n");
      out.write("            <div class=\"px-6 py-3 mt-auto cursor-pointer\">\n");
      out.write("                <form action=\"logout.jsp\" method=\"post\">\n");
      out.write("                    <button type=\"submit\" class=\"w-full bg-red-500 text-white py-2 rounded hover:bg-red-600\">Logout</button>\n");
      out.write("                </form>\n");
      out.write("            </div>\n");
      out.write("        </nav>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("    <!-- Main Content -->\n");
      out.write("    <div class=\"w-full flex flex-col items-center p-4 md:p-8 justify-center h-full\">\n");
      out.write("        <div class=\"w-full max-w-6xl mx-auto p-6 bg-white rounded-lg shadow-lg h-full overflow-auto\">\n");
      out.write("            \n");
      out.write("            <!-- Display User Details -->\n");
      out.write("            <h1 class=\"text-3xl font-bold mb-4 text-emerald-500\">Hello, ");
      out.print( user.getFirst_name() );
      out.write(' ');
      out.print( user.getLast_name() );
      out.write("!</h1>\n");
      out.write("            <p class=\"text-gray-600 mb-6\">Welcome to VoteStream's Online Voting System</p>\n");
      out.write("\n");
      out.write("            <!-- User Details Section -->\n");
      out.write("            <div class=\"grid grid-cols-1 md:grid-cols-3 gap-6\">\n");
      out.write("                <!-- Registration Date -->\n");
      out.write("                <div class=\"bg-white p-6 rounded-lg shadow border border-emerald-100\">\n");
      out.write("                    <p class=\"text-sm font-semibold text-gray-600\">Register Date</p>\n");
      out.write("                    <h2 class=\"text-4xl font-bold text-emerald-500\">\n");
      out.write("                        ");

                            if (user.getCreated_at() != null) {
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
                                out.print(sdf.format(user.getCreated_at()));
                            } else {
                                out.print("N/A");
                            }
                        
      out.write("\n");
      out.write("                    </h2>\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <!-- Number of Votes Used -->\n");
      out.write("                <div class=\"bg-white p-6 rounded-lg shadow border border-emerald-100\">\n");
      out.write("                    <p class=\"text-sm font-semibold text-gray-600\">Number of votes used</p>\n");
      out.write("                    <h2 class=\"text-4xl font-bold text-emerald-500\">");
      out.print( votesUsed );
      out.write("</h2>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("\n");
      out.write("            <!-- Ongoing Election -->\n");
      out.write("            <div class=\"grid grid-cols-1 md:grid-cols-2 gap-6 mt-6\">\n");
      out.write("                <div class=\"bg-white p-6 rounded-lg shadow border border-emerald-100\">\n");
      out.write("                    ");

                        String ongoingElectionName = "No Ongoing Election";
                        Connection con = null;
                        PreparedStatement ongoingPstmt = null;
                        ResultSet ongoingRs = null;

                        try {
                            con = db_connector.getConnection();
                            String ongoingQuery = "SELECT `election name` FROM elections WHERE status = 'Started' LIMIT 1";
                            ongoingPstmt = con.prepareStatement(ongoingQuery);
                            ongoingRs = ongoingPstmt.executeQuery();

                            if (ongoingRs.next()) {
                                ongoingElectionName = ongoingRs.getString("election name");
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (ongoingRs != null) try { ongoingRs.close(); } catch (Exception ignore) {}
                            if (ongoingPstmt != null) try { ongoingPstmt.close(); } catch (Exception ignore) {}
                            if (con != null) try { con.close(); } catch (Exception ignore) {}
                        }
                    
      out.write("\n");
      out.write("                    <h2 class=\"text-lg font-bold text-emerald-500\">");
      out.print( ongoingElectionName );
      out.write("</h2>\n");
      out.write("                    <p class=\"text-sm text-gray-600\">Ongoing Election</p>\n");
      out.write("                    ");
 if (!ongoingElectionName.equals("No Ongoing Election")) { 
      out.write("\n");
      out.write("                        <a href=\"poll.jsp\" class=\"mt-4 px-4 py-2 bg-emerald-500 text-white rounded-lg inline-block text-center hover:bg-emerald-600\">\n");
      out.write("                            Vote Now\n");
      out.write("                        </a>\n");
      out.write("                    ");
 } 
      out.write("\n");
      out.write("                </div>\n");
      out.write("\n");
      out.write("                <!-- Calendar -->\n");
      out.write("                <div class=\"bg-white p-6 rounded-lg shadow border border-emerald-100\">\n");
      out.write("                    <h2 class=\"text-lg font-bold text-emerald-500\">Calendar</h2>\n");
      out.write("                    <p class=\"mt-2 text-sm text-gray-600\">Today</p>\n");
      out.write("                    <p class=\"text-lg font-semibold text-emerald-500\">");
      out.print( new SimpleDateFormat("MMMM dd, yyyy").format(new java.util.Date()) );
      out.write("</p>\n");
      out.write("                </div>\n");
      out.write("            </div>\n");
      out.write("                 <!-- Election Activities Section -->\n");
      out.write("                <div class=\"grid grid-cols-1 md:grid-cols-2 gap-6 mt-6\">\n");
      out.write("                    <div class=\"bg-white p-6 rounded-lg shadow border border-emerald-100\">\n");
      out.write("                        <h2 class=\"text-lg font-bold text-emerald-500\">Election Activities</h2>\n");
      out.write("                        <ul class=\"mt-2 space-y-2\">\n");
      out.write("                            ");

                                // Fetch election data from the database
                                con = db_connector.getConnection();
                                String query = "SELECT `election name`, status FROM elections";
                                PreparedStatement pstmt = con.prepareStatement(query);
                                ResultSet rs = pstmt.executeQuery();
                                
                                while (rs.next()) {
                                    
                                    String electionName = rs.getString("election name");
                                    String status = rs.getString("status");
                            
      out.write("\n");
      out.write("                            <li class=\"flex justify-between\">\n");
      out.write("                                <span class=\"text-gray-700\">");
      out.print( electionName );
      out.write("</span>\n");
      out.write("                                <span class=\"text-gray-500\">");
      out.print( status );
      out.write("</span>\n");
      out.write("                            </li>\n");
      out.write("                            ");

                                }
                                rs.close();
                                pstmt.close();
                                con.close();
                            
      out.write("\n");
      out.write("                        </ul>\n");
      out.write("                    </div>\n");
      out.write("                </div>\n");
      out.write("        </div>\n");
      out.write("    </div>\n");
      out.write("\n");
      out.write("</body>\n");
      out.write("</html>");
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
