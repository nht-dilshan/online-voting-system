package classes;

import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class candidate {

    private int candidate_id;
    private String name;
    private String party_name;
    private String description;
    private int election_id; // New field

    public candidate() {
    }

    public candidate(String name, String party_name, String description, int election_id) {
        this.name = name;
        this.party_name = party_name;
        this.description = description;
        this.election_id = election_id; // Initialize election_id
    }

    public int getCandidate_id() {
        return candidate_id;
    }

    public void setCandidate_id(int candidate_id) {
        this.candidate_id = candidate_id;
    }

    public int getElection_id() {
        return election_id;
    }

    public void setElection_id(int election_id) {
        this.election_id = election_id;
    }

    public boolean register(Connection con) {
        String query = "INSERT INTO candidates (name, party_name, description, election_id) VALUES (?, ?, ?, ?)";
        try (PreparedStatement pstmt = con.prepareStatement(query)) {
            pstmt.setString(1, this.name);
            pstmt.setString(2, this.party_name);
            pstmt.setString(3, this.description);
            pstmt.setInt(4, this.election_id); // Add election_id to the query

            int rowsInserted = pstmt.executeUpdate();
            return rowsInserted > 0; // Return true if insertion was successful
        } catch (Exception e) {
            e.printStackTrace(); // Log the exception for debugging
            return false; // Return false if any error occurs
        }
    }
}