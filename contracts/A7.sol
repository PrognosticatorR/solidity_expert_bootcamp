// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Homework7 {
    struct CallParams {
        bytes4 funcSelector;
        uint256 amount;
        address target;
    }

    /*
    "transfer(address,uint256)"
    "transferFrom(address,address,uint256)"
    0xa9059cbb000000000000000000000000000000000000000000000000000000000000000000000000000000005b38da6a701c568545dcfcb03fcb875f56beddc40000000000000000000000000000000000000000000000000000000034e872ec
    */

    event transferOccurred(address target, uint256 value);

    function getSelector(string calldata _func) private pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    function encodeBytes(string calldata _func, address target, uint256 amount)
        external
        pure
        returns (bytes memory data)
    {
        bytes4 selector = getSelector(_func);
        data = abi.encode(selector, target, amount);
    }

    function decodeBytes(bytes calldata _data) public pure returns (CallParams memory data) {
        data = abi.decode(_data, (CallParams));
    }

    function checkCall(bytes calldata _data, string calldata _func) external {
        CallParams memory data = this.decodeBytes(_data);
        require(data.funcSelector == getSelector(_func), "Incorrect Selector!");
        emit transferOccurred(data.target, data.amount);
    }

    function query(uint256 _amount, address _receiver, bytes4 X) public {
        //addr is address of ERC20 contract
        (bool success,) = addr.call(abi.encodeWithSelector(X, _receiver, _amount));
        if (!success) {
            revert("Failed");
        }
    }
}
