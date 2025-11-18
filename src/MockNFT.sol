// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/Base64.sol";

contract MockNFT is ERC721, Ownable {
    using Strings for uint256;

    /// @notice Next token id to mint (starts at 1)
    uint256 public nextTokenId = 1;

    constructor(
        string memory name_,
        string memory symbol_,
        address owner_
    ) ERC721(name_, symbol_) Ownable() {
        // Transfer ownership to the specified owner (v4.9.6 sets deployer as initial owner)
        if (owner_ != msg.sender) {
            _transferOwnership(owner_);
        }
    }

    /// @notice Mint a new token to `to`. Only owner can call.
    /// @return tokenId The minted token id.
    function mint(address to) external onlyOwner returns (uint256 tokenId) {
        tokenId = nextTokenId;
        nextTokenId++;
        _safeMint(to, tokenId);
    }

    /// @notice Returns a data:application/json;base64 tokenURI containing a base64-encoded plain-text ASCII image.
    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        // ensure token exists using the project's OpenZeppelin helper
        _requireMinted(tokenId);

        // Static ASCII art. This is the "image" content (plain text).
        string memory art = string(
            abi.encodePacked(
                unicode"⠀⠀⠀⠀⠀⠀⢱⣆⠀⠀⠀⠀⠀⠀\n",
                unicode"⠀⠀⠀⠀⠀⠀⠈⣿⣷⡀⠀⠀⠀⠀\n",
                unicode"⠀⠀⠀⠀⠀⠀⢸⣿⣿⣷⣧⠀⠀⠀\n",
                unicode"⠀⠀⠀⠀⡀⢠⣿⡟⣿⣿⣿⡇⠀⠀\n",
                unicode"⠀⠀⠀⠀⣳⣼⣿⡏⢸⣿⣿⣿⢀⠀\n",
                unicode"⠀⠀⠀⣰⣿⣿⡿⠁⢸⣿⣿⡟⣼⡆\n",
                unicode"⢰⢀⣾⣿⣿⠟⠀⠀⣾⢿⣿⣿⣿⣿\n",
                unicode"⢸⣿⣿⣿⡏⠀⠀⠀⠃⠸⣿⣿⣿⡿\n",
                unicode"⢳⣿⣿⣿⠀⠀⠀⠀⠀⠀⢹⣿⡿⡁\n",
                unicode"⠀⠹⣿⣿⡄⠀⠀⠀⠀⠀⢠⣿⡞⠁\n",
                unicode"⠀⠀⠈⠛⢿⣄⠀⠀⠀⣠⠞⠋⠀⠀\n",
                unicode"⠀⠀⠀⠀⠀⠀⠉⠀⠀⠀⠀⠀⠀⠀\n"
            )
        );

        // Base64-encode the plain-text ASCII art and wrap as a data URI
        string memory imageBase64 = Base64.encode(bytes(art));
        string memory imageData = string(
            abi.encodePacked("data:text/plain;base64,", imageBase64)
        );

        string memory name = string(
            abi.encodePacked("Mock NFT #", tokenId.toString())
        );
        string
            memory description = "A simple mock NFT that embeds static ASCII art as its image.";

        bytes memory json = abi.encodePacked(
            '{"name":"',
            name,
            '","description":"',
            description,
            '","image":"',
            imageData,
            '"}'
        );

        string memory jsonBase64 = Base64.encode(json);
        return
            string(
                abi.encodePacked("data:application/json;base64,", jsonBase64)
            );
    }
}
