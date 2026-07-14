// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

contract FistContract{
    bool public bool_value = false;
    address public owner;
    string public str1 = "string";
    constructor(){
        owner = msg.sender;
        console.log("You deployed contract at", address(this));
        console.log("Owner balance", owner.balance);
    }

    function set_string(string calldata newstr) external{
        str1 = newstr;
    }

    function recursion(uint n) public returns(uint256){
        if(n<=1){
            return 1;
        }
        return n * this.recursion(n-1);
    }

    uint[5] public arr = [1,2,3,4,5];

    uint[] public dynamic_array;

    function init_array(uint[] calldata init) public {
        for(uint idx; idx < init.length; idx++){
            console.log("%d - %d", idx, init[idx]);
            dynamic_array.push(init[idx]);
        }
    }

    function remove_last() public {
        console.log(dynamic_array[dynamic_array.length-1]);
        dynamic_array.pop();
    }

    function print_array() public{
        for(uint idx; idx < dynamic_array.length; idx++){
            console.log("%d - %d", idx, dynamic_array[idx]);
        }
    }

    function remove_by_index(uint idx) public {
        if(idx > dynamic_array.length - 1){
            revert("Index out of range");
        }
        delete dynamic_array[idx];
    }

    mapping(address => uint) public balance;

    function write_balance() public {
        balance[msg.sender] = msg.sender.balance;
    }

    bytes1 public one_type = "b";
    function decode(bytes calldata data) public returns(string memory){
        return string(data);
    }
    enum Status {Paid, Delievered, Recieved}
    Status public product_status = Status.Delievered;

    struct Payment{
        uint value;
        uint timestap;
        address from;
        string messeg;
    }

    Payment[] public payments;

    function donate(string calldata message) external payable {
        payments.push(Payment(msg.value, block.timestamp, msg.sender, message));
    }

    function transfer(address to) public payable {
        payable(to).transfer(msg.value);
    }
}