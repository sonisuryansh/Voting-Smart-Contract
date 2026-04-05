// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Vote {

    enum VotingStatus { NotStarted, InProgress, Ended }
    enum Gender { NotSpecified, Male, Female, Other }

    struct Voter {
        string name;
        uint age;
        uint voterId;
        Gender gender;
        uint votedCandidateId;
        address voterAddress;
    }

    struct Candidate {
        string name;
        string party;
        uint age;
        Gender gender;
        uint candidateId;
        address candidateAddress;
        uint votes;
    }

    address public electionCommission;
    address public winner;

    uint public nextVoterId = 1;
    uint public nextCandidateId = 1;
    uint public maxCandidates = 5;

    uint public startTime;
    uint public endTime;

    bool public stopVoting;
    bool public resultDeclared;

    mapping(uint => Voter) public voterDetails;
    mapping(uint => Candidate) public candidateDetails;

    mapping(address => bool) public isVoterRegistered;
    mapping(address => bool) public isCandidateRegistered;
    mapping(address => uint) public voterIdByAddress;


    event VoterRegistered(address voter, uint voterId);
    event CandidateRegistered(address candidate, uint candidateId);
    event VoteCasted(address voter, uint candidateId);
    event WinnerDeclared(address winner);

    constructor() {
        electionCommission = msg.sender;
    }

    modifier onlyCommissioner() {
        require(msg.sender == electionCommission, "Not authorized");
        _;
    }

    modifier isValidAge(uint _age) {
        require(_age >= 18, "Not eligible");
        _;
    }

    modifier isVotingActive() {
        require(block.timestamp >= startTime, "Voting not started");
        require(block.timestamp <= endTime, "Voting ended");
        require(!stopVoting, "Voting stopped");
        _;
    }

    modifier resultNotDeclared() {
        require(!resultDeclared, "Result already declared");
        _;
    }

    function registerCandidate(
        string calldata _name,
        string calldata _party,
        uint _age,
        Gender _gender
    ) external isValidAge(_age) {

        require(!isCandidateRegistered[msg.sender], "Already registered");
        require(nextCandidateId <= maxCandidates, "Limit reached");
        require(msg.sender != electionCommission, "Commission cannot register");

        candidateDetails[nextCandidateId] = Candidate({
            name: _name,
            party: _party,
            age: _age,
            gender: _gender,
            candidateId: nextCandidateId,
            candidateAddress: msg.sender,
            votes: 0
        });

        isCandidateRegistered[msg.sender] = true;

        emit CandidateRegistered(msg.sender, nextCandidateId);

        nextCandidateId++;
    }

    function registerVoter(
        string calldata _name,
        uint _age,
        Gender _gender
    ) external isValidAge(_age) {

        require(!isVoterRegistered[msg.sender], "Already registered");

        voterDetails[nextVoterId] = Voter({
            name: _name,
            age: _age,
            voterId: nextVoterId,
            gender: _gender,
            votedCandidateId: 0,
            voterAddress: msg.sender
        });

        voterIdByAddress[msg.sender] = nextVoterId;
        isVoterRegistered[msg.sender] = true;

        emit VoterRegistered(msg.sender, nextVoterId);

        nextVoterId++;
    }

    function castVote(uint _candidateId) external isVotingActive resultNotDeclared {

        require(isVoterRegistered[msg.sender], "Not a voter");

        uint voterId = voterIdByAddress[msg.sender];
        Voter storage voter = voterDetails[voterId];

        require(voter.votedCandidateId == 0, "Already voted");
        require(_candidateId >= 1 && _candidateId < nextCandidateId, "Invalid candidate");

        voter.votedCandidateId = _candidateId;
        candidateDetails[_candidateId].votes++;

        emit VoteCasted(msg.sender, _candidateId);
    }

    function setVotingPeriod(uint _startDelay, uint _duration) external onlyCommissioner {
        require(_duration >= 1 hours, "Minimum 1 hour");

        startTime = block.timestamp + _startDelay;
        endTime = startTime + _duration;
    }

    function getVotingStatus() public view returns (VotingStatus) {
        if (startTime == 0) return VotingStatus.NotStarted;
        if (block.timestamp <= endTime && !stopVoting) return VotingStatus.InProgress;
        return VotingStatus.Ended;
    }

    function announceVotingResult() external onlyCommissioner {

        require(block.timestamp > endTime || stopVoting, "Voting not ended");

        uint maxVotes = 0;
        address win;

        for (uint i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].votes > maxVotes) {
                maxVotes = candidateDetails[i].votes;
                win = candidateDetails[i].candidateAddress;
            }
        }

        winner = win;
        resultDeclared = true;

        emit WinnerDeclared(winner);
    }

    function getWinner() public view returns (Candidate memory) {
        require(resultDeclared, "Result not declared");

        for (uint i = 1; i < nextCandidateId; i++) {
            if (candidateDetails[i].candidateAddress == winner) {
                return candidateDetails[i];
            }
        }

        revert("Winner not found");
    }

    function getCandidateList() public view returns (Candidate[] memory) {
        Candidate[] memory list = new Candidate[](nextCandidateId - 1);

        for (uint i = 0; i < list.length; i++) {
            list[i] = candidateDetails[i + 1];
        }

        return list;
    }

    function getVoterList() public view returns (Voter[] memory) {
        Voter[] memory list = new Voter[](nextVoterId - 1);

        for (uint i = 0; i < list.length; i++) {
            list[i] = voterDetails[i + 1];
        }

        return list;
    }

    function emergencyStopVoting() external onlyCommissioner {
        stopVoting = true;
    }

    function reset_Election() external onlyCommissioner {

        for (uint i = 1; i < nextCandidateId; i++) {
            delete candidateDetails[i];
        }

        for (uint i = 1; i < nextVoterId; i++) {
            address voterAddr = voterDetails[i].voterAddress;
            delete isVoterRegistered[voterAddr];
            delete voterIdByAddress[voterAddr];
            delete voterDetails[i];
        }

        nextCandidateId = 1;
        nextVoterId = 1;
        winner = address(0);
        stopVoting = false;
        resultDeclared = false;
    }
}
