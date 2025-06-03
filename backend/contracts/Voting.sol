// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Voter {
        bool isRegistered;
        bool hasVoted;
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public owner;
    uint public maxVoters;
    uint public registeredVoterCount;
    Proposal[] public proposals;
    mapping(address => Voter) public voters;

    constructor(bytes32[] memory proposalNames, uint _maxVoters) {
        owner = msg.sender;
        maxVoters = _maxVoters;

        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Seul le proprietaire peut appeler cette fonction.");
        _;
    }

    function register() external {
        require(!voters[msg.sender].isRegistered, "Deja inscrit.");
        require(registeredVoterCount < maxVoters, "Limite d'inscriptions atteinte.");

        voters[msg.sender] = Voter({
            isRegistered: true,
            hasVoted: false
        });
        registeredVoterCount++;
    }

    function vote(uint proposalIndex) external {
        Voter storage sender = voters[msg.sender];
        require(sender.isRegistered, "Vous n'etes pas inscrit.");
        require(!sender.hasVoted, "Vous avez deja vote.");
        require(proposalIndex < proposals.length, "Proposition invalide.");

        sender.hasVoted = true;
        proposals[proposalIndex].voteCount++;
    }

    function getProposal(uint index) external view returns (Proposal memory) {
        require(index < proposals.length, "Index invalide.");
        return proposals[index];
    }

    function getProposalCount() external view returns (uint) {
        return proposals.length;
    }

    function getWinningProposal() external view returns (uint winningProposalIndex) {
        uint maxVotes = 0;
        for (uint i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > maxVotes) {
                maxVotes = proposals[i].voteCount;
                winningProposalIndex = i;
            }
        }
    }

    function isRegistered(address addr) external view returns (bool) {
        return voters[addr].isRegistered;
    }

    function hasVoted(address addr) external view returns (bool) {
        return voters[addr].hasVoted;
    }
}
