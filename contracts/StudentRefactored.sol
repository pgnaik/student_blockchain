// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {
    string public name;
    uint public marks;

    function setStudent(string memory _name, uint _marks) external {
        name = _name;
        marks = _marks;
    }

    function getResult() external view returns (string memory) {
        return marks >= 40 ? "Pass" : "Fail";
    }
}