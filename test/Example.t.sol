// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/Test.sol";
import "../src/Example.sol";

contract ExampleTest is Test {
    FreeApp public freeApp;

    function setUp() public {
        freeApp = new FreeApp();
    }

    function testInc() public {
        freeApp.inc();
        assertEq(freeApp.num(), 1);
    }

    function testFailDec() public {
        freeApp.dec();
    }

    function testDecUnderflow() public {
        vm.expectRevert(stdError.arithmeticError);
        freeApp.dec();
    }

    function testDec() public {
        freeApp.inc();
        freeApp.inc();
        freeApp.dec();
        assertEq(freeApp.num(), 1);
    }
}
