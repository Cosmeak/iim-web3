// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Ballot {
    struct Voter {
        bool hasVoted; // if the person as already voted
        uint vote; // index of the vote
        bool exists; // used to check if a voter exists in the map
    }

    struct Proposal {
        bytes32 name;
        uint count;
    }

    address public chairman; // contract owner

    bool private isOpen = false; // define if the ballot is currently open

    uint private nbMaxVoter; // define the maximum voter possible
    uint private nbVoters = 0; // define the current number of voters

    mapping(address => Voter) public voters; // all voters address

    Proposal[] public proposals; // all proposals

    modifier chairmanOnly() {
        require(msg.sender == chairman, "Only the chairman can execute this action");
        _;
    }

    modifier ballotIsOpen() {
        require(isOpen == true, "The ballot is not currently open");
        _;
    }

    modifier canVote(address voter) {
        require(!voters[voter].hasVoted, "The voter has already voted.");
        _;
    }

    modifier ballotIsMaxed() {
        require(nbVoters > nbMaxVoter, "Maximum number of voters is reached.");
        _;
    }

    // Create a new ballot to choose one of the proposals
    constructor(bytes32[] memory proposalNames, uint nbMaxVoter_) {
        chairman = msg.sender;

        nbMaxVoter = nbMaxVoter_;       

        // For each proposal names, create a new Proposal Object and push it to the array
        // of available proposals
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                count: 0
            }));
        }
    }

    function toggleOpen() public chairmanOnly {
        isOpen = !isOpen;
    }

    // Give to the voter the right to vote on this ballot by the chairman
    function giveRightToVote(address voter)
        public
        chairmanOnly
        ballotIsOpen
        canVote(voter)
        ballotIsMaxed
    {    
        voters[voter].hasVoted = false;
        nbVoters++;

        if (nbVoters == nbMaxVoter) {
            toggleOpen();
        }
    }
 
    // Add a vote to a proposal
    function vote(uint proposal) public ballotIsOpen canVote(msg.sender) {
        Voter storage voter = voters[msg.sender];
        voter.hasVoted = true;
        voter.vote = proposal;
        proposals[proposal].count++;
    }

    function checkVoted() external view returns (bool) {
        return voters[msg.sender].hasVoted;
    }

    function checkRegistered() external view returns (bool) {
        return voters[msg.sender].exists;
    }

    function getMostVotedProposal() external view returns (Proposal memory proposal) {
        require(proposals.length > 0, "No proposals available.");
        uint highestCount = 0;
        bool equality = false;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].count > highestCount) {
                proposal = proposals[i];
                highestCount = proposal.count;
            }
        }

        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].count == highestCount && proposals[i].name != proposal.name) {
                equality = true;
                break;
            }
        }

        require(!equality, "There is an ex aequo.");
    }

    function getAllProposals() external view returns (Proposal[] memory) {
        Proposal[] memory items = new Proposal[](proposals.length);
        for (uint i = 0; i < proposals.length; i++) {
            items[i] = proposals[i];
        }

        return items;
    }
}
