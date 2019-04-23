pragma solidity ^0.5.0;

contract Election {
    // model a candidate
    // Read candidate
    struct Candidate {
      uint id;
      string name;
      uint voteCount;
    }

    // Store candidate, id to candidate stuct
    // set it to public, it generates fetch function
    mapping(uint => Candidate) public candidates;

    // Store Candidates Court
    uint public candidatesCount;

    // Constructor
    constructor () public {
      addCandidate('Coda');
      addCandidate('Alice');
    }

    // _name means private varaible
    function addCandidate(string memory _name) private {
      candidatesCount ++;
      candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }
}
