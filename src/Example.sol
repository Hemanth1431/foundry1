// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract FreeApp{
    uint public num;

    function get()public view returns(uint){
        return(num);
    }
    function inc()public{
        num += 1;
    }

    function dec()public{
        num -= 1;
    }
}