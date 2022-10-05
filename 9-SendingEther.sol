// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Bank {
    
    mapping(address => uint) balances;

    // bir fonksiyona msg.value ile ether gönderiliyorsa onu payable olarak işaretlemek gerekiyor
    function sendEtherToContract() payable external {
        balances[msg.sender] = msg.value;
    }

    function showBalance() external view returns(uint) {
        return balances[msg.sender];
    }

    // eğer bir hesaba ether gönderilecekse yine payable kullanılmalı
    function withDraw(address payable to, uint amount) external returns(bool) {
        // require(balances[msg.sender]>=amount, "Yeterli bakiye bulunmuyor");
        
        // 1. Yöntem
        // to.transfer(amount);    // transfer fonksiyonu yukarıdaki kodu kendi içerisinde yapıyor

        // 2. Yöntem
        // bool result = to.send(amount);  // başarılıysa true, başarısızsa false döner

        // 3. Yöntem
        (bool sent,) = to.call{value:amount}("");

        if(sent) balances[msg.sender] -= amount;
        
        return sent;
    }

    // kontratımıza ether geldiğinde kendiliğinden çalışan özel bir fonksiyon
    receive() external payable {
        // 
    }

    // kontrata data geldiğinde de fallback çalışır
    fallback() external payable {
        // 
    }


}