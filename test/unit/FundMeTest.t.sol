// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";
import {console} from "forge-std/console.sol";
import {DeployFundMeScript} from "../../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe public fundMe;

    address USER = makeAddr("user");
    address DEPLOYER = makeAddr("deployer");

    uint256 constant AMOUNT = 0.1 ether;
    uint256 constant STARTING_BALANCE = 10 ether;

    function setUp() external {
        //fundMe = new FundMe();
        DeployFundMeScript deployFundMe = new DeployFundMeScript();
        fundMe = deployFundMe.run();
        vm.deal(USER, STARTING_BALANCE);
    }

    function testMunim_UsdIsFive() public {
        assertEq(fundMe.MINIMUM_USD(), 5 * 10 ** 18);
    }

    function testIsOwnerMsgSender() public {
        assertEq(fundMe.getOwner(), msg.sender);   
    }

    function testpriseFeedVersionIsAccurate() public {
        uint256 version = fundMe.getVersion();
        assertEq(version, 4);
    }

    function testFundFailsWithoutEnoughEth() public {
        vm.expectRevert();
        fundMe.fund();
    }

    function testFundUpdatesFundedDataStructure() public {
        vm.prank(USER);
        
        fundMe.fund{value: AMOUNT}();
        uint256 amountFunded = fundMe.getAddressToAmountFunded(USER);
        assertEq(amountFunded, AMOUNT);
    }

    function testAddFundersToArryOfList() public {
        vm.prank(USER);
        fundMe.fund{value: AMOUNT}();   

        address funders = fundMe.getFundersList(0);
        assertEq(funders, USER);
    }

    modifier funded() {
        vm.prank(USER);
        fundMe.fund{value: AMOUNT}();   
        _;
    }

    function testOnlyOwnerCanWithdraw() public funded {
        vm.expectRevert();
        fundMe.withdraw();

    }
    function testWithdrawWithASingleFunder() public funded {
        
        uint startingOwnerBalance = fundMe.getOwner().balance;
        uint startingFundMeBalance = address(fundMe).balance;

        vm.prank(fundMe.getOwner());
        fundMe.withdraw();

        uint endingOwnerBalance = fundMe.getOwner().balance;
        uint endingFundMeBalance = address(fundMe).balance;
        assertEq(endingFundMeBalance, 0);
        assertEq(startingFundMeBalance + startingOwnerBalance, endingOwnerBalance);
    }
    function testWithdrawFromMultipleFunders() public funded {
        uint160 numberOfFunders = 10;
        uint160 startingFunderIndex = 1;
        for(uint160 i = startingFunderIndex; i < numberOfFunders; i++) {
            hoax(address(i), AMOUNT);
            fundMe.fund{value: AMOUNT}();
        }

        uint startingOwnerBalance = fundMe.getOwner().balance;
        uint startingFundMeBalance = address(fundMe).balance;

        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();
        vm.stopPrank();

        
        assert(address(fundMe).balance == 0);
        assert(startingFundMeBalance + startingOwnerBalance == fundMe.getOwner().balance);
    }
    //(gas: 488356)
}