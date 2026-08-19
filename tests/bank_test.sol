// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "remix_tests.sol";
import "../bank.sol";
contract BankTest {
    Bank bank;
    function beforeAll() public {
        bank = new Bank();
    }

    function checkInitialBalance() public {
        Assert.equal(
            bank.balance(address(this)),
            uint(0),
            "Initial balance should be zero"
        );
    }
}
