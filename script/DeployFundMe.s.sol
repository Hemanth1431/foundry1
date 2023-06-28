// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfi} from "./HelperConfi.s.sol";

contract DeployFundMeScript is Script {
    function run() external returns (FundMe) {
        HelperConfi helperConfig = new HelperConfi();
        address ethUsdPriceFeed = helperConfig.activeNetworkCongi();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
