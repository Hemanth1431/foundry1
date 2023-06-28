// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract SimpleContract {
    address private owner;
    uint256 private num;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "!owner");
        _;
    }

    function getOwner() external view returns (address) {
        return owner;
    }

    function updateOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    function setNum(uint256 _num) external {
        num = _num;
    }

    function getNum() external view returns (uint256) {
        return num;
    }
}
