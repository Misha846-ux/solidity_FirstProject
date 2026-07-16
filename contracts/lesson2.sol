// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

library MyLib{
    function getSum(uint a, uint b) pure external returns (uint){
        return a + b;
    }
}

contract Sample{
    using MyLib for uint;

    error NotOwner(address init);
    error MinValue(uint expected, uint current);

    event WithdrawEvent(uint value);
    event DonateEvent(address indexed sender, uint value);

    address owner;

    modifier isOwner(){
        require(msg.sender != owner, NotOwner(msg.sender));
        _;
    }

    modifier minValue(uint min_value){
        require(msg.value >= min_value, MinValue(min_value, msg.value));
        _;
    }

    constructor(){
        owner = msg.sender;
    }

    function donate() external payable {
        console.log("!!New donate");
        emit DonateEvent(msg.sender, msg.value);
    }

    function withdraw() isOwner external {
        /*
        if(msg.sender != owner){
            revert NotOwner(msg.sender);
        }
        */
        //require(msg.sender != owner, NotOwner(msg.sender));
        //assert(msg.sender != owner);

        uint contract_balance = address(this).balance;
        payable(owner).transfer(contract_balance);
        console.log("Owner gets ETH from contract");
        emit WithdrawEvent(contract_balance);

    }

    function only_owner() external view isOwner returns (string memory){
        return "Success";
    }

}