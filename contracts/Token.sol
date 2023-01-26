// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Token {
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;
    string name_;
    string symbol_;
    uint256 totalSupply_;
    uint8 decimal_;

    constructor(string memory _name, string memory _symbol, uint256 total, uint8 decimal){
        name_ = _name;
        symbol_ = _symbol;
        totalSupply_ = total;
        decimal_ = decimal;
        balances[msg.sender] = totalSupply_;
    }

    function name() public view returns (string memory) {
        return name_;
    }

    function symbol() public view returns (string memory) {
        return symbol_;
    }

    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }

    function decimals() public view returns (uint8) {
        return decimal_;
    }

    function transfer(address _receiver, uint _amount) public returns (bool) {
        require(_amount <= balances[msg.sender]);
        balances[msg.sender] -= _amount;
        balances[_receiver] += _amount;
        return true;
    }

    function balanceOf(address tokenOwner) public view returns (uint) {
        return balances[tokenOwner];
    }

    function approve(address _delegate, uint _amount) public returns (bool) {
        allowed[msg.sender][_delegate] = _amount;
        return true;

        //prevent front-running attack  
        // require(_amount == 0 || allowed[msg.sender][_delegate] == 0);  
        // allowed[msg.sender][_delegate] = _amount; 
        // // emit Approval(msg.sender, _spender, _value); 
        // return true;
    }

    function allowance(address _owner, address _delegate) public view returns (uint) {
        return allowed[_owner][_delegate];
    }

    function transferFrom(address _owner, address _receiver, uint _amount) public returns (bool) {
        require(_amount <= balances[_owner]);
        require(_amount <= allowed[_owner][msg.sender]);

        balances[_owner] -= _amount;
        allowed[_owner][msg.sender] -= _amount;
        balances[_receiver] += _amount;
        return true;
    }
}