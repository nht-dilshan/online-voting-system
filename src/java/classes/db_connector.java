package classes;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class db_connector {

    private static final String DRIVER = "com.mysql.jdbc.Driver";
    private static final String URL = "jdbc:mysql://localhost:3306/voting_system";
    private static final String DBUSER = "root";
    private static final String DBPW = "";

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName(DRIVER);
            con = DriverManager.getConnection(URL, DBUSER, DBPW);
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(db_connector.class.getName()).log(Level.SEVERE, "Database connection failed", ex);
        }
        return con;
    }
}
