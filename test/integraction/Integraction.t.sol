// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {console} from "forge-std/console.sol";
import {DeployFundMeScript} from "../../script/DeployFundMe.s.sol";
import {FundFundMe, WithdrawFundMe} from "../../script/integraction.s.sol";

contract IntegractionTest is Test{
    FundMe public fundMe;

    address USER = makeAddr("user");

    uint256 constant AMOUNT = 1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        //fundMe = new FundMe();
        DeployFundMeScript deployFundMe = new DeployFundMeScript();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testUserCanFundInteractions() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
