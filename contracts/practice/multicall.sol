// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract MultiCall {
    function multicall(address[] calldata targets, bytes[] calldata _data) external view returns (bytes[] memory) {
        uint256 datalength = _data.length;
        uint256 methodsToCall = targets.length;
        bytes[] memory result = new bytes[](datalength);
        for (uint256 i = 0; i < methodsToCall;) {
            (bool success, bytes memory res) = targets[i].staticcall(_data[i]);
            require(success, "call failed");
            result[i] = res;
            unchecked {
                ++i;
            }
        }
        return result;
    }
}

contract TestContract is MultiCall {
    function addition(uint256 x, uint256 y) external pure returns (uint256, bool) {
        return (x + y, true);
    }

    function multiplication(uint256 x, uint256 y) external pure returns (uint256, bool) {
        return (x * y, true);
    }

    function getAddictionSelector(uint256 x, uint256 y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.addition.selector, x, y);
    }

    function getMultiplicationSelector(uint256 x, uint256 y) external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.multiplication.selector, x, y);
    }
}

contract DecodeResults {
    function decodeBytes(bytes calldata _data) external pure returns (uint256, bool) {
        uint256 d1 = abi.decode(_data[:32], (uint256));
        bool d2 = abi.decode(_data[32:], (bool));
        return (d1, d2);
    }
}
