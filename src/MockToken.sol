// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MockToken is ERC20, Ownable {
    constructor(
        string memory name,
        string memory symbol,
        uint256 initialSupply,
        address owner
    ) ERC20(name, symbol) Ownable() {
        // Transfer ownership to the specified owner (v4.9.6 sets deployer as initial owner)
        if (owner != msg.sender) {
            _transferOwnership(owner);
        }
        _mint(owner, initialSupply * 10 ** decimals());
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function burnFrom(address account, uint256 amount) public {
        _spendAllowance(account, msg.sender, amount);
        _burn(account, amount);
    }
}
