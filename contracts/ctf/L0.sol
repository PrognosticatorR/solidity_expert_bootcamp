// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Level_0_Solution {
    function solution() external pure returns (uint256 val) {
        assembly {
            val := 42
        }
    }
}
