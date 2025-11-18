// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "forge-std/Test.sol";
import "../src/MockNFT.sol";

contract MockNFTTest is Test {
    MockNFT public nft;
    address public owner = address(0x1);
    address public user1 = address(0x2);
    address public user2 = address(0x3);

    function setUp() public {
        vm.prank(owner);
        nft = new MockNFT("Test NFT", "TNFT", owner);
    }

    function testMint() public {
        vm.prank(owner);
        uint256 tokenId = nft.mint(user1);

        assertEq(tokenId, 0);
        assertEq(nft.ownerOf(tokenId), user1);
        assertEq(nft.balanceOf(user1), 1);
    }

    function testTokenURI() public {
        vm.prank(owner);
        uint256 tokenId = nft.mint(user1);

        string memory uri = nft.tokenURI(tokenId);
        assertTrue(bytes(uri).length > 0);
        assertTrue(bytes(uri)[0] == bytes("d")[0]); // starts with "data:"
    }

    function testOnlyOwnerCanMint() public {
        vm.prank(user1);
        vm.expectRevert("Ownable: caller is not the owner");
        nft.mint(user1);
    }

    function testOwnershipTransferred() public {
        assertEq(nft.owner(), owner);
    }
}
