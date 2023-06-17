// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../src/SendEth.sol";

contract SendEthTest is Test{
    SendEth public sendEth;

    //deal(address, uint) = set balance of address
    //hoax(address, uint) = deal + prank, sets up a prank, set balance

    function setUp()public{
        sendEth = new SendEth();
    }

    function _send(uint256 amount) private{
        (bool ok, ) = address(sendEth).call{value: amount}("");
        require(ok, "call failed");
    }

    function testEthBalnce()public{
        console.log("Get Balance",address(this).balance/1e18);
    }

    function testSendEth()public{
        uint bal = address(sendEth).balance;
        //deal(address, uint) = set balance of address
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        //hoax(address, uint) = deal + prank, sets up a prank, set balance
        deal(address(2), 123);
        vm.prank(address(2));
        _send(123);

        hoax(address(2), 456);
        _send(456);

        assertEq(address(sendEth).balance, bal + 123 + 456);

    }



}
