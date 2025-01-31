/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package classes;

import classes.candidate;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author NHT-Dilshan
 */
public class election {
    


public class Election {
    private int electionId;
    private String title;
    private Date startDate;
    private Date endDate;
    private String status;
    private List<candidate> candidates;

    // Constructors
    public Election() {}

    public Election(int electionId, String title, Date startDate, Date endDate, String status) {
        this.electionId = electionId;
        this.title = title;
        this.startDate = startDate;
        this.endDate = endDate;
        this.status = status;
    }

    // Getters and Setters
    public int getElectionId() { return electionId; }
    public void setElectionId(int electionId) { this.electionId = electionId; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public Date getStartDate() { return startDate; }
    public void setStartDate(Date startDate) { this.startDate = startDate; }
    public Date getEndDate() { return endDate; }
    public void setEndDate(Date endDate) { this.endDate = endDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public List<candidate> getCandidates() { return (List<candidate>) candidates; }
    public void setCandidates(List<candidate> candidates) { this.candidates = candidates; }

    // Methods
    public boolean createElection() {
        // Implementation for creating election
        return true;
    }

    public boolean startElection() {
        // Implementation for starting election
        return true;
    }

    public boolean endElection() {
        // Implementation for ending election
        return true;
    }

    public Map<candidate, Integer> getResults() {
        // Implementation for getting results
        return new HashMap<>();
    }
}
    
}
