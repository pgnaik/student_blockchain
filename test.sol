//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract EtherReceiver{
  address public owner;
  constructor(){
    owner=msg.sender;
  }

  receive() external payable{
  } 

  function withdraw() external{
    require(msg.sender==owner, "Only owner can widthdraw Ether");
    payable(msg.sender).transfer(address(this).balance);
  } 
}