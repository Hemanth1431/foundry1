// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

import "forge-std/console.sol";

contract FreeApp {
    uint256 public num;

    function get() public view returns (uint256) {
        return (num);
    }

    function inc() public {
        console.log("Here", num);
        num += 1;
    }

    function dec() public {
        num -= 1;
    }
}
