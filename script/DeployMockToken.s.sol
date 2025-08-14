// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "forge-std/Script.sol";
import "../src/MockToken.sol";

contract DeployMockToken is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        string memory name = vm.envOr("TOKEN_NAME", string("MockToken"));
        string memory symbol = vm.envOr("TOKEN_SYMBOL", string("MTK"));
        uint256 initialSupply = vm.envOr("INITIAL_SUPPLY", uint256(1000000));

        MockToken token = new MockToken(name, symbol, initialSupply, deployer);

        vm.stopBroadcast();

        console.log("MockToken deployed to:", address(token));
        console.log("Token name:", name);
        console.log("Token symbol:", symbol);
        console.log("Initial supply:", initialSupply);
        console.log("Owner:", deployer);
    }
}
