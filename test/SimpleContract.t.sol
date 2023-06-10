// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "forge-std/console.sol";

import "../src/SimpleContract.sol";

contract SimpleContractTest is Test {
    SimpleContract simpleContract;

    address public deployer = makeAddr("deployer");
    address public user = makeAddr("user");

    function setUp() external {
        vm.prank(deployer);
        simpleContract = new SimpleContract();

        console.log("owner address: ", simpleContract.getOwner());
    }

    function testFail_Owner() external{
        assertEq(simpleContract.getOwner(),user);
    }

    function test_updateOwner() external {
        vm.prank(deployer);
        simpleContract.updateOwner(user);

        console.log("owner address: ", simpleContract.getOwner());
        assertEq(simpleContract.getOwner(),deployer);
    } 


}