// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/Greet.sol";

contract GreetTest is Test {
    HelloWorld public helloworld;

    function setUp() public {
        helloworld = new HelloWorld();
    }

    function testgreet() public {
        assertEq(helloworld.greets(), "Hello Hemanth!");
    }
}
