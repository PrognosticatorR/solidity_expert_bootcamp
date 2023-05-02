// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Add {
    function addAssembly(uint256 x, uint256 y) public pure returns (uint256) {
        assembly {
            let result := add(x, y)
            mstore(0x40, result)
        }

        assembly {
            return(0x40, 32)
        }
    }
}
