// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SendEth {
    address payable private owner;

    event Depodite(address account, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Depodite(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "caller is not owner");
        owner.transfer(_amount);
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "caller is not owner");
        owner = payable(_owner);
    }
}
