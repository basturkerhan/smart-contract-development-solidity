// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

library Math {
    
    function plus(uint x, uint y) public pure returns(uint) {
        return x+y;
    }

    function minus(uint x, uint y) public pure returns(uint) {
        return x-y;
    }

    function divide(uint x, uint y) public pure returns(uint) {
        require(y != 0, "Sifira bolunemez");
        return x/y;
    }

}

contract Library {

    function trial(uint x, uint y) public pure returns(uint) {
        return Math.plus(x,y);
    }

    // using ile ekleyip aşağıdaki trialUsing fonksiyonu gibi de kullanılabilir
    using Math for uint;
    function trialUsing(uint x, uint y) public pure returns(uint) {
        return x.plus(y);
    }

}