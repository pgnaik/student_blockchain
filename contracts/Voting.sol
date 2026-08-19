// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    mapping(address => bool) public hasVoted;
    mapping(string => uint) public voteCount;
    string[] public candidateList;

    constructor(string[] memory _candidates) {
        candidateList = _candidates;
    }

    function vote(string memory _candidate) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(isValidCandidate(_candidate), "Invalid candidate");
        voteCount[_candidate]++;
        hasVoted[msg.sender] = true;
    }

    function isValidCandidate(string memory _candidate) internal view returns (bool) {
        for (uint i = 0; i < candidateList.length; i++) {
            if (keccak256(bytes(candidateList[i])) == keccak256(bytes(_candidate))) {
                return true;
            }
        }
        return false;
    }

    function getTotalVotes() external view returns (uint) {
        uint total = 0;
        for (uint i = 0; i < candidateList.length; i++) {
            total += voteCount[candidateList[i]];
        }
        return total;
    }
}