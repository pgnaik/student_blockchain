// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract MyToken {
    string public name = "MyToken";
    string public symbol = "MTK";
    uint8 public decimals = 18;
    uint public totalSupply;

    mapping(address => uint) public balanceOf;

    constructor(uint _supply) {
        totalSupply = _supply * 10**decimals;
        balanceOf[msg.sender] = totalSupply;
    }

    function transfer(address _to, uint _tokens) public returns (bool) {
    uint amount = _tokens * 10**decimals;   // convert to smallest units

    require(balanceOf[msg.sender] >= amount, "Insufficient balance");

    balanceOf[msg.sender] -= amount;
    balanceOf[_to] += amount;

    return true;
   }
}
