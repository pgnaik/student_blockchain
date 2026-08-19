// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Student {

    string public name;
    uint public blockchain_marks;

    function setStudent(string memory n, uint m) public {
        name = n;
        blockchain_marks = m;
    }

    function getResult() public view returns (string memory) {
        if (blockchain_marks >= 40) {
            return "Pass";
        } else {
            return "Fail";
        }
    }
}
