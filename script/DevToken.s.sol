// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

import "forge-std/Script.sol";
import {DevToken} from "../src/DevToken.sol";

contract DeployDevToken is Script {
    function run() external returns (address) {
        vm.startBroadcast();

        // Set initial supply to 1 million tokens
        uint256 initialSupply = 1_000_000 * 10 ** 6;
        DevToken implementation = new DevToken(initialSupply);

        vm.stopBroadcast();

        console.log("DevToken deployed at:", address(implementation));

        return address(implementation);
    }
}
