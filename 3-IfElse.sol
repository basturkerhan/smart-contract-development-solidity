// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract IfElse {
    bytes32 private _hashedPassword;
    uint private _loginCount = 0;

    constructor(string memory password) {
        _hashedPassword = keccak256(abi.encode(password)); // hashleme algoritması ile metni hashledik
    }

    function login(string memory _password) public returns(bool) {
        _loginCount++;
        return (_hashedPassword == keccak256(abi.encode(_password))); // hash karşılaştırma işlemi
    }

    function loginStatus() public view returns(uint256) {
        if(_loginCount==0) {
            return 0;
        } else if( (_loginCount > 0) && (_loginCount != 1) ) {
            return 1;
        } else {
            return 2;
        }
    }


}