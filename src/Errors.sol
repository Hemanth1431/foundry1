// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.17;

contract Error{
    error NotAuthorised();

    function throwError()external{
        require(false, "not authorised");
    }

    function throwCustomError()external{
        revert NotAuthorised();
    }
}