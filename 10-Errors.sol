// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract Errors {
    uint256 public totalBalance;
    mapping(address => uint256) public userBalances;

    error ExceedingAmount(address user, uint256 exceedingAmount);
    error Deny(string reason);

    // kontrata receive ile para girilmesini engellemek istiyoruz, sadece bizim yazdığımız metodlarla giriş olsun
    receive() external payable {
        revert Deny("No direct payments");
    }

    // kontrata fallback ile para girilmesini engellemek istiyoruz, sadece bizim yazdığımız metodlarla giriş olsun
    fallback() external payable {
        revert Deny("No direct payments");
    }


    function pay() noZero(msg.value) external payable {
        require(msg.value == 1 ether, "Yalnizca 1 etherlik odeme yapabilirsin");
        totalBalance += 1 ether;
        userBalances[msg.sender] += 1 ether;
    }


    function withdraw(uint256 _amount) noZero(_amount) external {
        uint256 initialBalance = totalBalance; // assert hata yakalama metodu için başlangıç balance değeri

        // require dan farklı bir hata yakalama yöntemi
        if(userBalances[msg.sender] < _amount) {
            // revert("Yetersiz bakiye");
            revert ExceedingAmount(msg.sender, _amount - userBalances[msg.sender]);
        }

        totalBalance -= _amount;
        userBalances[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);

        assert(totalBalance < initialBalance);  // aslında bu fonksiyonda bu kısım hiç çalışmayacak çünkü
        // içerisi hep true olacak ama doğru çalıştığından kesinlikle emin olmak istiyorsak bu tarzda bir hata
        // yönetimi metodu da kullanmakta fayda var. Genelde test aşamalarında kullanılıyor.
    }




    modifier noZero(uint256 _amount) {
        require(_amount != 0, "");
        _;
    }



}