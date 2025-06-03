// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Ballot {
    struct Person {
        bool voted; // if the person as already voted
        uint vote; // index of the vote
    }

    struct Proposal {
        bytes32 name;
        uint voteCount;
    }

    address public owner; // contract owner

    mapping(address => Person) public voters; // all voters address

    Proposal[] public proposals; // all proposals

    constructor(bytes32[] memory proposalNames) {
        owner = msg.sender;
        voters[owner];

        // For each proposal names, create a new Proposal Object and push it to the array
        // of available proposals
        for (uint i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({
                name: proposalNames[i],
                voteCount: 0
            }));
        }
    }
}
