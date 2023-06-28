// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Events.sol";

contract Eventtest is Test {
    Event public eve;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        eve = new Event();
    }

    function testEmitTransferEvent() public {
        vm.expectEmit(true, true, false, true);
        emit Transfer(address(this), address(123), 456);
        eve.transfer(address(this), address(123), 456);
        //check index 1;
        /*vm.expectEmit(true, false, false, false);
        emit Transfer(address(this), address(123), 456);
        eve.transfer(address(this), address(13), 46);
        */
    }

    function testEmitTransferMany() public {
        address[] memory to = new address[](2);
        to[0] = address(1783);
        to[1] = address(8907);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 7890;
        amounts[1] = 6784;

        for (uint256 i; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }

        eve.transferMany(address(this), to, amounts);
    }
}
