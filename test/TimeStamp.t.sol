// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TimeStamp.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startAt;

    function setUp() public {
        auction = new Auction();
        startAt = block.timestamp;
    }
    //vm.warp() = set block.timestamp to future timestamp
    // vm.roll() = set block.number
    //skip() = increase current timestamp
    //rewind = decrease current timestamp

    function testBidFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot revert"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidFailsAfterEndTime() public {
        vm.expectRevert(bytes("cannot revert"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimeStamp() public {
        uint256 t = block.timestamp;
        skip(100);
        assertEq(block.timestamp, t + 100);

        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }
}
