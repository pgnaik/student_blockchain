// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    string public name;
    uint public marks;

    function setStudent(string memory n, uint m) public {
        name = n;
        marks = m;
    }

    function getResult() public view returns (string memory) {
        if (marks >= 40) {
            return "Pass";
        } else {
            return "Fail";
        }
    }
}
