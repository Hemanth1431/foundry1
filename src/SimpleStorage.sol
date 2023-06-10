// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleStorage {
    uint256 public num;
    address public owner;

    function getOwner() public view returns(uint256 value){
        // assembly {
        //     let x := num.slot
        //     value := sload(x)
        // }

        return num;
    }
}