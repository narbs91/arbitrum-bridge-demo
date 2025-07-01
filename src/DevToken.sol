// SPDX-License-Identifier: Apache-2.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

/**
 * @title DevToken
 * @author @narbs91
 * This is a demo token contract demonstrating how to create a token with a max supply and a burn function
 * NOTE: Do not use this contract in a production environment as it has not been audited
 * @dev The dev token has 6 decimals
 * @dev The dev token has a max supply of 1 billion tokens
 */
contract DevToken is ERC20Burnable {
    ////////////////////////////////
    ///////// State Variables //////
    ////////////////////////////////
    string private constant NAME = "Dev Token";
    string private constant SYMBOL = "DEV";

    // Max supply of 1 billion tokens
    uint256 public constant MAX_SUPPLY = 1_000_000_000 * 10 ** 6;

    ////////////////////////////////
    ///////// Errors ///////////////
    ////////////////////////////////
    error DevToken__NotEnoughBalance();
    error DevToken__MaxSupplyReached();
    error DevToken__AmountMustBeGreaterThanZero();
    error DevToken__InvalidAddress();

    ////////////////////////////////
    ///////// Modifiers ////////////
    ////////////////////////////////
    modifier moreThanZero(uint256 amount) {
        if (amount == 0) {
            revert DevToken__AmountMustBeGreaterThanZero();
        }
        _;
    }

    ////////////////////////////////
    ///////// Functions ////////////
    ////////////////////////////////
    constructor(uint256 initialSupply) ERC20(NAME, SYMBOL) moreThanZero(initialSupply) {
        if (initialSupply > MAX_SUPPLY) {
            revert DevToken__MaxSupplyReached();
        }
        _mint(msg.sender, initialSupply);
    }

    function decimals() public view virtual override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) external moreThanZero(amount) returns (bool) {
        if (totalSupply() + amount > MAX_SUPPLY) {
            revert DevToken__MaxSupplyReached();
        }

        _mint(to, amount);
        return true;
    }

    function burn(uint256 amount) public override moreThanZero(amount) {
        if (amount > balanceOf(msg.sender)) {
            revert DevToken__NotEnoughBalance();
        }

        super.burn(amount);
    }
}
