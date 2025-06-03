// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Ballot {
    struct Voter {
        bool hasVoted; // if the person as already voted
        uint vote; // index of the vote
    }

    struct Proposal {
        bytes32 name;
        uint count;
    }

    address public chairman; // contract owner

    bool private isOpen = false; // define if the ballot is currently open

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

    // Create a new ballot to choose one of the proposals
    constructor(bytes32[] memory proposalNames) {
        chairman = msg.sender;

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
    function giveRightToVote(address voter) public chairmanOnly ballotIsOpen canVote(voter) {
        voters[voter].hasVoted = false;
    }
 
    // Add a vote to a proposal
    function vote(uint proposal) public ballotIsOpen canVote(msg.sender) {
        Voter storage voter = voters[msg.sender];
        voter.hasVoted = true;
        voter.vote = proposal;
        proposals[proposal].count++;
    }

    function getWinningProposal() public view returns (uint winningProposal_) {
        uint highestCount = 0;
        for (uint i = 0; i < proposals.length; i++) {
            highestCount = proposals[i].count;
            winningProposal_ = i;
        }
    }

    function getWinnerName() public view returns (bytes32 winnerName_) {
        winnerName_ = proposals[getWinningProposal()].name;
    }

    function getAllProposals() external view returns (Proposal[] memory) {
        Proposal[] memory items = new Proposal[](proposals.length);
        for (uint i = 0; i < proposals.length; i++) {
            items[i] = proposals[i];
        }

        return items;
    }
}
