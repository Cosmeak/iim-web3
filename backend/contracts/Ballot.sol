// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Ballot {
    struct Person {
        bool voted; // if the person as already voted
        uint vote; // index of the vote
    }

    struct Proposal {
        bytes32 name;
        uint count;
    }

    address public chairman; // contract owner

    mapping(address => Person) public voters; // all voters address

    Proposal[] public proposals; // all proposals

    // Create a new ballot to choose one of the proposals
    constructor(bytes32[] memory proposalNames) {
        chairman = msg.sender;
        voters[chairman];

        // For each proposal names, create a new Proposal Object and push it to the array
        // of available proposals
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                count: 0
            }));
        }
    }

    // Give to the voter the right to vote on this ballot by the chairman
    function addNewVoter(address voter) public {
        require(msg.sender == chairman, "Only the chairman can give the right to vote.");
        require(!voters[voter].voted, "The voter has already voted.");
        voters[voter].voted = false;
    }
 
    // Add a vote to a proposal
    function vote(uint proposal) public {
        Person storage sender = voters[msg.sender];
        require(!sender.voted, "Already voted!");
        sender.voted = true;
        sender.vote = proposal;
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
