// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 < 0.9.0;

import "hardhat/console.sol";

library ArrayLibrary {
    function search(uint[] calldata arr, uint ellement)pure external returns(int){
        for(uint i = 0; i < arr.length; i++ ){
            if(arr[i] == ellement){
                return int(i);
            }
        }
        return -1;
    }

    function sort(uint[] memory arr) pure internal  {
        for(uint i = 0; i < arr.length - 1; i++){
            for(uint j = i + 1; j < arr.length; j++){
                if(arr[i] > arr[j]){
                    uint cell = arr[i];
                    arr[i] = arr[j];
                    arr[j] = cell;
                }
            }
        }
    }

    function deleteEl(uint[] memory arr, uint index) pure internal returns(uint[] memory){
        uint[] memory newArr = new uint[](arr.length-1);
        uint j = 0;
        for(uint i = 0; i < arr.length; i++){
            if(i == index){
                continue;
            }
            newArr[j++] = arr[i];
        }
        return newArr;
    }
}

contract ArrayUtils{

    using ArrayLibrary for uint[];

    function SearchArrElement(uint[] calldata arr, uint element) pure external returns (int){
        int answer = arr.search(element);
        return answer;
    }
    function SortArr(uint[] memory arr) pure external {
        arr.sort();
        for(uint i = 0; i < arr.length; i++){
            console.log(arr[i]);
        }
    }

    function DeleteElement(uint[] memory arr, uint index) pure external {
        uint[] memory newArr = arr.deleteEl(index);
        for(uint i = 0; i < newArr.length; i++){
            console.log(newArr[i]);
        }
    }

}