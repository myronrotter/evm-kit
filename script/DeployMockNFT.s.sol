// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Script.sol";
import "../src/MockNFT.sol";

contract DeployMockNFT is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerPrivateKey);

        vm.startBroadcast(deployerPrivateKey);

        string memory name = vm.envOr("NFT_NAME", string("MockNFT"));
        string memory symbol = vm.envOr("NFT_SYMBOL", string("MNFT"));

        MockNFT nft = new MockNFT(name, symbol, deployer);

        vm.stopBroadcast();

        console.log("MockNFT deployed to:", address(nft));
        console.log("NFT name:", name);
        console.log("NFT symbol:", symbol);
        console.log("Owner:", deployer);
    }
}
