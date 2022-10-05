// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Mapping {
    mapping(address => bool) public registered;

    function register() public {
        // registered[msg.sender] = true; // daha önceden true ise yeniden true yapacak kayıp olacak
        
        require(!isRegistered(),"Kullanici daha once kayit yapti"); // msg.sender false olmalı ki devamını yapsın deniliyor
        registered[msg.sender] = true; // artık kayıp yok sadece 1 kere yapıyoruz
    }

    function isRegistered() public view returns(bool) {
        return registered[msg.sender];
    }

    function deleteRegistered() public {
        require(isRegistered(),"Kullanici zaten mevcut degil");
        delete(registered[msg.sender]);
    }
    
}


contract NestedMapping {
    // bir adrese karşılık gelen o adrese borçlu adreslerin, o adrese olan borç miktarı
    mapping(address => mapping(address => uint256)) public debts;

    function incDebt(address _borrower, uint256 _amount) public {
        debts[msg.sender][_borrower] += _amount;

    }

    function decDebt(address _borrower, uint256 _amount) public {
        require(getDept(_borrower) >= _amount, "Not enough debt");
        debts[msg.sender][_borrower] -= _amount;
    }

    function getDept(address _person) public view returns (uint256) {
        return debts[msg.sender][_person];
    }

}