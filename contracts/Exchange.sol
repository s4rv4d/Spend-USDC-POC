// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./Token.sol";

contract Exchange {
    Token token;
    address public tokenAddress;

    constructor(address _token) payable {
        require(msg.value > 0, "You have to deposit something to start a dex");
        tokenAddress = _token;
        token = Token(address(tokenAddress));
    }

    function setAllowance(uint256 amount, address tokenOwner) public {
        uint256 tokenOwnerBal = token.balanceOf(tokenOwner);
        require(amount > 0, "You need set an allowance higher than 0");
        require(tokenOwnerBal > 0, "The token owner has insufficient balance");
        require(amount <= tokenOwnerBal, "amount is greater than tokenOwnerBal");

        // set approval
        token.approve(address(tokenOwner), amount);
    }

    function performTradeForSpecificAmount(uint256 amount, address tokenOwner) public {
        
    }
}

// requires a function to set an allowance first