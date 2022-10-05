// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract Functions {
    // uint luckyNumber = 6;

    // function showNumber() public view returns(uint) {
    //     return luckyNumber;
    // }

    uint public luckyNumber = 6;

    function setNumber(uint newNumber) public {
        luckyNumber = newNumber;
    }

    // herhangi bir okuma yapmayacağım içeride, kendi halinde çalışacak => pure
    function nothing() public pure returns(uint, bool, bool) {
        return (5, true, false);
    }

    function nothing2() public pure returns(uint x, bool y, bool z) {
        x = 6;
        y = true;
        z = false;
    }

    // sadece görüntüleme işlemi yapıyorum state üzerinde bir değişiklik yapmıyorum
    function showNumber() public view returns(uint) {
        return luckyNumber;
    }

    // stringlerin hangi lokasyonda tutulduğunu tanımlamak gerekiyor
    function publicKeyword() public pure returns(string memory) {
        return "Bu bir public fonksiyondur";
    }

    // dışarıdan yine kullanılamasın ama kontratı miras alanlar da kullanabilsin
    function InternalKeyword() internal pure returns(string memory) {
        return "Bu bir internal fonksiyondur";
    }

    // External => dışarıdan kullanıcılar çağırabilr ama kontrat içerisinde çağırılmaz. Gas tasarrufu yapmayı sağlar
    function ExternalKeyword() external pure returns(string memory) {
        return "Bu bir external fonksiyondur";
    }
}