// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

// virtual  => gövdesi miras alan yerde değiştirilebilecek fonksiyonlar
// override => miras alınan yerde değiştirebilmek için gerekli işaret

contract A {
    uint public x;
    uint public y;

    function setX(uint _x) virtual public {
        x = _x;
    }

    function setY(uint _y) public {
        y = _y;
    }

}


contract B is A {
    uint public z;

    function setZ(uint _z) public {
        z = _z;
    }

    // override edilen fonksiyon örneği
    function setX(uint _x) override public {
        x = _x + 2;
    }
}


contract Human {
    function sayHello() public pure virtual returns(string memory) {
        return "itublockchain.com adresi uzerinden kulube uye olabilirsiniz :)";
    }
}

contract SuperHuman is Human {
    function sayHello() public pure override returns(string memory) {
        return "Selamlar itu blockchain uyesi, nasilsin ? :)";
    }

    function welcomeMsg(bool isMember) public pure returns(string memory) {
        return isMember ? sayHello() : super.sayHello();    // super ile miras alınan sınıfın fonksiyonuna erişilebiliniyor
    }
}