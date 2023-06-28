// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "solmate/tokens/ERC20.sol";

contract Token is ERC20("name", "symble", 18) {}

import "@openzeppelin/contracts/access/Ownable.sol";

contract TestOP is Ownable {}
