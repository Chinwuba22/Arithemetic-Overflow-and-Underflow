// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;

/**
 * @title Example of a contract with an overflow issue
 * @author Uba Chris (Extracted from https://solidity-by-example.org/hacks/overflow/)
 * @notice This is expected to be a simple contract which makes deposits, locks the deposit for a certain period of time, then allows for withdrawals
 */
contract TimeLock {
    mapping(address => uint256) public balances;
    mapping(address => uint256) public lockTime;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
        lockTime[msg.sender] = block.timestamp + 1 weeks;
    }

    function increaseLockTime(uint256 _secondsToIncrease) public {
        lockTime[msg.sender] += _secondsToIncrease;
    }

    function withdraw() public {
        require(balances[msg.sender] > 0, "Insufficient funds");
        require(block.timestamp > lockTime[msg.sender], "Lock time not expired");

        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;

        (bool sent,) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
