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

    function solution3(uint256[2][2] calldata, uint256[2][2] calldata) external pure returns (uint256[2][2] memory) {
        assembly {
            // Matrix visualization:
            // [32B, 32B]
            // [32B, 32B] = 128B total
            // Get free memory pointer. As each elem has 32B size, we will increment freePt by 32 each time.
            let freePt := mload(0x40)
            // x starts with an offset of 4B to calldata.
            // Store x[0][0] + y[0][0] in freePt
            mstore(freePt, add(calldataload(4), calldataload(132)))
            // Store x[0][1] + y[0][1] in freePt + 32B
            mstore(add(freePt, 32), add(calldataload(36), calldataload(164)))
            // Store x[1][0] + y[1][0] in freePt + 64B
            mstore(add(freePt, 64), add(calldataload(68), calldataload(196)))
            // Store x[1][1] + y[1][1] in freePt + 96B
            mstore(add(freePt, 96), add(calldataload(100), calldataload(228)))
            // Return the 128B of the array, grabbing from freePt.
            return(freePt, 128)
        }
    }

    function solution2(uint8[2][2] calldata x, uint8[2][2] calldata y) external pure returns (uint8[2][2] memory) {
        uint8[2][2] memory result;
        result[0][0] = x[0][0] + y[0][0];
        result[0][1] = x[0][1] + y[0][1];
        result[1][0] = x[1][0] + y[1][0];
        result[1][1] = x[1][1] + y[1][1];
        return result;
    }
}

// [ [ 2, 2 ], [ 2, 2 ] ] [ [ 4, 4 ], [ 4, 4 ] ]
