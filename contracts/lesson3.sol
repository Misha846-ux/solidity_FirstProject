// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

contract BaseContract{
    uint private_field;
    string internal message = "Hello from parent";

    function get_state() public virtual view returns (string memory, string memory){
        return ("Parrent", message);
    }
}

contract DerivedContract is BaseContract{
    constructor(){
        message = "Hello from derived";
    }

    function get_message() external view returns(string memory){
        return message;
    }

    function get_state() public override view returns (string memory, string memory){
        return ("Derived", message);
    }
}

abstract contract Token{
    uint internal coins;
    function mint() internal virtual;
    function get_coins_count() external view returns (uint){
        return coins;
    }
}

contract AwesomeToken is Token{
    constructor(){
        mint();
    }
    function mint() internal override {
        coins = 99999999999999999999;
    }
}

contract MultiplyDerived is BaseContract, Token{
    function mint() internal override {
        coins = 9999999999999999;
    }
    
}