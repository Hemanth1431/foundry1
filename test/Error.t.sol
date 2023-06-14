// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Errors.sol";

contract ErrorTest is Test{
    Error public err;

    function setUp()external{
        err = new Error();
    }

    function testFail()external{
        err.throwError();
    }

    function testRevert()external{
        vm.expectRevert();
        err.throwError();
    }

    function testRequireMessage()external{
        vm.expectRevert(bytes("not authorised"));
        err.throwError();
    }

    function testCustomErrors()external{
        vm.expectRevert(Error.NotAuthorised.selector);
        err.throwCustomError();
    }


}

