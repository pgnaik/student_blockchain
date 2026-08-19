// SPDX-License-Identifier: MIT
pragma solidity >0.6.0;
contract Bank {
    mapping(address => uint) public balance;

    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }

    function withdraw(uint amount) public {
        require(balance[msg.sender] >= amount);
        balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }
}

