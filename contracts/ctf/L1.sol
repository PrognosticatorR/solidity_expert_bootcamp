// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

contract Level_1_Solution {
    function solution(uint256[2][2] calldata x, uint256[2][2] calldata y)
        external
        pure
        returns (uint256[2][2] memory)
    {
        uint256[2][2] memory result;
        assembly {
            let freeMemoryPointer := add(result, 64)
            for { let i := 0 } lt(i, 4) { i := add(i, 1) } {
                mstore(freeMemoryPointer, add(calldataload(add(x, mul(32, i))), calldataload(add(y, mul(32, i)))))
                freeMemoryPointer := add(freeMemoryPointer, 32)
            }
        }
        return result;
    }

    function solution2(uint256[2][2] calldata x, uint256[2][2] calldata y) external pure returns (uint256[2][2] memory) {
        uint256[2][2] memory result;
        result[0][0] = x[0][0] + y[0][0];
        result[0][1] = x[0][1] + y[0][1];
        result[1][0] = x[1][0] + y[1][0];
        result[1][1] = x[1][1] + y[1][1];
        return result;
    }
}

// [ [ 2, 2 ], [ 2, 2 ] ] [ [ 4, 4 ], [ 4, 4 ] ]
