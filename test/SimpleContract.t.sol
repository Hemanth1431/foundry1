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

    function testFail_Owner() public {
        assertEq(simpleContract.getOwner(), user);
    }

    function testOwnerUpdate() public {
        vm.prank(deployer);
        simpleContract.updateOwner(user);
        console.log("address user", user);
        assertEq(simpleContract.getOwner(), user);
    }
}
