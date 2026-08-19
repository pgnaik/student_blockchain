// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Bank {

    mapping(address => uint) public balance;

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balance[msg.sender] >= amount);

        (bool success,) = msg.sender.call{value: amount}("");

        require(success);

        balance[msg.sender] -= amount;
    }
}