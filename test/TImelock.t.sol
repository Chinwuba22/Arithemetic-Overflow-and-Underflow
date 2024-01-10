// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.6;
pragma abicoder v2;

import {Test, console2} from "forge-std/Test.sol";
import {TimeLock} from "../src/Timelock.sol";
import {Attack} from "../src/Attack.sol";

contract OverflowTest is Test {
    TimeLock public timeLock;
    Attack public attacker;
    address USER = makeAddr("user");

    function setUp() public {
        timeLock = new TimeLock();
        attacker = new Attack(address(timeLock));
        vm.deal(USER, 10 ether);
    }

    function test_cannotWithdrawTillAfterAWeek() public payable {
        //This proves that withdrawal requests will be reverted when enough time has not passed
        vm.startPrank(USER);
        timeLock.deposit{value: 1 ether}();
        vm.expectRevert();
        timeLock.withdraw();
        vm.stopPrank();
    }

    //Proof that it can be withdrawn immediately
    function test_attackScenario() public {
        //The assertion here proves that it can be withdrawn instantly.
        vm.startPrank(USER);
        attacker.attack{value: 1 ether}();
        assertEq(address(timeLock).balance, 0);
        vm.stopPrank();
    }
}
