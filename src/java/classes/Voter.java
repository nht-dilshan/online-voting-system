package classes;


import classes.user;
import classes.candidate;
import classes.election;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Voter extends user {
    private int voterId;
    private boolean hasVoted;

    // Constructors
    public Voter() {}

    public Voter(int voterId, boolean hasVoted) {
        this.voterId = voterId;
        this.hasVoted = hasVoted;
    }

    // Getters and Setters
    public int getVoterId() { return voterId; }
    public void setVoterId(int voterId) { this.voterId = voterId; }
    public boolean isHasVoted() { return hasVoted; }
    public void setHasVoted(boolean hasVoted) { this.hasVoted = hasVoted; }

    // Methods
    public boolean castVote() {
        // Implementation for casting vote
        return true;
    }

    public List<election> viewElections() {
        // Implementation for viewing elections
        return new ArrayList<>();
    }

    public Map<candidate, Integer> viewResults() {
        // Implementation for viewing results
        return new HashMap<>();
    }
}