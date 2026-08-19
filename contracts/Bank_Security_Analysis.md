# Bank Contract Security Analysis

## Overview
A simple Ethereum-based bank contract allowing users to deposit, withdraw, and check their ETH balance.

---

## Functions

### `deposit()`
- **Visibility**: `public payable`
- **Purpose**: Adds the sent ETH (`msg.value`) to the caller's balance.
- **Security**: Safe (no external calls or reentrancy risks).

### `withdraw(uint amount)`
- **Visibility**: `public`
- **Purpose**: Deducts `amount` from the caller's balance and transfers it back to them.
- **Security**:
  - **Reentrancy**: Mitigated by using `transfer` (2300 gas limit) and following *checks-effects-interactions*.
  - **Underflow**: Prevented by `require(balance[msg.sender] >= amount)`.

### `checkBalance()`
- **Visibility**: `public view`
- **Purpose**: Returns the caller's balance.
- **Security**: Safe (read-only function).

---

## Security Issues

### 1. **Reentrancy Risk (Low)**
- **Status**: Mitigated
- **Details**: `transfer` is used instead of `call.value()`, which limits reentrancy risks. The *checks-effects-interactions* pattern is correctly followed.

### 2. **Underflow Protection (Mitigated)**
- **Status**: Mitigated
- **Details**: The `require` check ensures `balance[msg.sender] >= amount` before deduction, preventing underflow.

### 3. **Lack of Access Control (Critical)**
- **Status**: Unresolved
- **Details**: No ownership or authorization checks. Anyone can withdraw funds if they know an address with a balance.
- **Recommendation**: Add an `owner` modifier or use OpenZeppelin's `Ownable` for critical functions.

### 4. **Front-Running (Low)**
- **Status**: Unresolved
- **Details**: Deposits and withdrawals can be front-run in a public mempool.
- **Recommendation**: Use commit-reveal schemes or Chainlink's Fair Sequencing Service (FSS) for sensitive operations.

### 5. **Gas Limits (Low)**
- **Status**: Mitigated
- **Details**: `transfer` enforces a 2300 gas limit, which may fail if the recipient is a contract with complex fallback logic.
- **Recommendation**: Consider using `call.value()` with reentrancy guards for better compatibility.

---

## Recommendations
1. **Add Access Control**: Restrict `withdraw` to authorized users or implement a proper ownership model.
2. **Use `call.value()` with Reentrancy Guard**: Replace `transfer` with `call.value()` and add a reentrancy guard (e.g., OpenZeppelin's `ReentrancyGuard`).
3. **Add Events**: Emit events for deposits and withdrawals to enable off-chain tracking.
4. **Test Edge Cases**: Verify behavior for zero-amount withdrawals, large deposits, and concurrent transactions.

---

## Example Fixes
```solidity
// Add OpenZeppelin's ReentrancyGuard and Ownable
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Bank is ReentrancyGuard, Ownable {
    mapping(address => uint) public balance;

    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);

    function deposit() public payable {
        balance[msg.sender] += msg.value;
        emit Deposited(msg.sender, msg.value);
    }

    function withdraw(uint amount) public nonReentrant {
        require(balance[msg.sender] >= amount, "Insufficient Balance");
        balance[msg.sender] -= amount;
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Transfer failed");
        emit Withdrawn(msg.sender, amount);
    }

    function checkBalance() public view returns (uint) {
        return balance[msg.sender];
    }
}
```
