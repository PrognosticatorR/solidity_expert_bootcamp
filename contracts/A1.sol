// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.19;

/// Write a function that will delete items (one at a time) from a dynamic array without leaving gaps in the array. You should assume that the items to be deleted are chosen at random, and try to do this in a gas efficient manner.
// For example imagine your array has 12 items and you need to delete the items at indexes 8, 2 and 7.
// The final array will then have items {0,1,3,4,5,6,9,10,11}

contract Assignment1 {
    function removeElement(uint256[] memory items, uint256 idx) public pure returns (uint256[] memory result_arr) {
        require(items.length > 0, "Empty Array");
        uint256 length = items.length;
        items[idx] = items[length - 1];
        assembly {
            mstore(items, sub(mload(items), 1))
        }
        return items;
    }

    function removeWithOrder(uint256[] memory items, uint256 idx) public pure returns (uint256[] memory result_arr) {
        require(items.length > 0, "Empty items array");
        for (uint256 i = idx; i < items.length - 1;) {
            items[i] = items[i + 1];
            unchecked {
                ++i;
            }
        }
        assembly {
            mstore(items, sub(mload(items), 1))
        }
        return items;
    }
}
