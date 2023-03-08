// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.6;

// import "./Token.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@pooltogether/v4-core/contracts/interfaces/IPrizePool.sol";
import "@openzeppelin/contracts/Access/Ownable.sol";

contract Exchange is Ownable {

    IERC20 token;
    IPrizePool pool;

    address public tokenAddress;

    constructor(address _token) {
        tokenAddress = _token;
    }

    function performTradeForSpecificAmount(uint256 amount, address tokenOwner) public onlyOwner {
        require(amount > 0, "amount needs to be greater than 0");

        token = IERC20(tokenAddress);
        // get approved amount first
        uint256 approvedAmount = token.allowance(tokenOwner, address(this));
        require(approvedAmount >= amount, "check the token allowance");

        // initiate transfer
        token.transferFrom(tokenOwner, address(this), amount);
        payable(msg.sender).transfer(amount);
    }

    function withdrawFromPool(address _contractAddr, address _fromAddress, address _tokenAddress, uint256 amount) public onlyOwner {
        require(amount > 0 , "amount should be greater than 0");

        token = IERC20(_tokenAddress);
        // get approved amount first
        uint256 approvedAmount = token.allowance(_fromAddress, address(this));
        require(approvedAmount >= amount, "check the token allowance");

        pool = IPrizePool(_contractAddr);
        pool.withdrawFrom(_fromAddress, amount);
    }
}