// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

interface IContractA {
    function set_value(uint value) external;
    function get_value() external view returns(uint);
    function pay() external payable;
}

contract A{
    uint _value = 0;
    address owner;
    constructor(){
        owner = msg.sender;
    }
    function set_value(uint value) external {
        _value = value;
    }

    function get_value() external view returns (uint){
        return _value;
    }

    function pay() external payable {

    }

    function withdraw() external {
        payable(owner).transfer(address(this).balance);
    }

    fallback() external payable {
        console.log("Fallback");
    }
    receive() external payable {
        console.log("Receive");
    }
}

contract B{
    address public  contractA;
    constructor(address other_contract){
        contractA = other_contract;
    }

    
    function pay () external payable {

    }
    function callDetSetValue(uint n_value) public returns (uint){
        (bool set_result, ) = contractA.call(abi.encodeWithSignature("set_value(uint256)", n_value));
        (bool get_result, bytes memory data) = contractA.call(abi.encodeWithSignature("get_value()"));
        return abi.decode(data, (uint));
    }

    function callPayable() public payable {
        (bool result, ) = contractA.call{value: msg.value}(abi.encodeWithSignature("pay()"));
    }

    function delegateSetValue(uint n_value)public {
        (bool set_result, ) = contractA.delegatecall(abi.encodeWithSignature("set_value(uint256)", n_value));
    }

    function delegateWithdraw() public {
        (bool set_result, ) = contractA.delegatecall(abi.encodeWithSignature("withdraw()"));
    }

    function staticcallGetValue() public view returns(uint){
        (bool get_result, bytes memory data) = contractA.staticcall(abi.encodeWithSignature("get_value()"));
        return abi.decode(data, (uint));
    }

    function interface_Call(uint n_value) public payable returns(uint) {
        IContractA contrA = IContractA(contractA);

        contrA.set_value(n_value);
        contrA.pay{value: msg.value}();
        return contrA.get_value();
    }

    function fallback_receive() external payable {
        (bool buy_result,) = contractA.call{value: msg.value}(abi.encodeWithSignature("buy()"));

        (bool nothing_result,) = contractA.call{value: msg.value}("");
    }
}