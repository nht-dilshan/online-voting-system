package classes;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class user {
    private int user_id;
    private String first_name;
    private String last_name;
    private String email;
    private String password_hash;
    private String role;
    private Timestamp created_at; // Add this field

    public user() {
    }

    public user(String email, String password_hash) {
        this.email = email;
        this.password_hash = MD5.getMd5(password_hash);
    }

    public user(String first_name, String last_name, String email, String password_hash, String role) {
        this.first_name = first_name;
        this.last_name = last_name;
        this.email = email;
        this.password_hash = MD5.getMd5(password_hash);
        this.role = role;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public void setFirst_name(String first_name) {
        this.first_name = first_name;
    }

    public void setLast_name(String last_name) {
        this.last_name = last_name;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getFirst_name() {
        return first_name;
    }

    public String getLast_name() {
        return last_name;
    }

    public String getRole() {
        return role;
    }

    public Timestamp getCreated_at() {
        return created_at;
    }

    public void setCreated_at(Timestamp created_at) {
        this.created_at = created_at;
    }

    public boolean register(Connection con) {
        try {
            String query = "INSERT INTO users(first_name,last_name,email,password_hash,role)VALUES(?,?,?,?,?)";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.first_name);
            pstmt.setString(2, this.last_name);
            pstmt.setString(3, this.email);
            pstmt.setString(4, this.password_hash);
            pstmt.setString(5, this.role);
            return pstmt.executeUpdate() > 0;
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public boolean authenticate(Connection con) {
        try {
            String query = "SELECT user_id, password_hash, first_name, last_name, role, created_at FROM users WHERE email = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, this.email);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                String db_password = rs.getString("password_hash");
                if (db_password.equals(this.password_hash)) {
                    this.user_id = rs.getInt("user_id");
                    this.first_name = rs.getString("first_name");
                    this.last_name = rs.getString("last_name");
                    this.role = rs.getString("role");
                    this.created_at = rs.getTimestamp("created_at");
                    return true;
                }
            }
            return false;
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public user getuserbyid(Connection con) {
        try {
            String query = "SELECT first_name, last_name, role, created_at FROM users WHERE user_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setInt(1, this.user_id);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                this.setFirst_name(rs.getString("first_name"));
                this.setLast_name(rs.getString("last_name"));
                this.setRole(rs.getString("role"));
                this.setCreated_at(rs.getTimestamp("created_at"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(user.class.getName()).log(Level.SEVERE, null, ex);
        }
        return this;
    }
}