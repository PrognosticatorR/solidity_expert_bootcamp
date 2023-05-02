// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Intro {
    function intro() public pure returns (uint16) {
        uint256 mol = 420;
        assembly {
            let var := mol
            mstore(0x40, var)
            return(0x40, 0x60)
        }
    }
}
