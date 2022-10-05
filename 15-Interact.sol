//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Interact {
    address public caller;
    mapping(address => uint256) public counts;

    function callThis() external {
        caller = msg.sender;    // caller değişkenine çağıranın adresini atıyoruz
        counts[msg.sender]++;   // çağıranın adresi ile eşleşen count 1 arttırılıyor
    }
}

// Bir kontrattan diğerine erişirken, msg.sender değeri her ne kadar çağıran cüzdanın adresi olsa da 
// çağrılan kontrattan baktığımız zaman ona gelen msg.sender değeri erişen kontrat olur.
// bu sebeple burada payEth fonksiyonu içerisine adresi parametre olarak yolluyoruz.
contract Pay {
    mapping(address => uint256) public userBalances;

    // receive,  fallback

    function payEth(address _payer) external payable {
        userBalances[_payer] += msg.value;
    }
}

// msg.sender -> A (mesaj yollayan: msg.sender) -> B (mesaj yollayan: A adresi)
// Bir kontrattan diğerine erişirken, msg.sender değeri her ne kadar çağıran cüzdanın adresi olsa da 
// çağrılan kontrattan baktığımız zaman ona gelen msg.sender değeri erişen kontrat olur.
// Yani Caller, Interact'a erişmek istediği zaman çağıranın cüzdan adresiyle değil kendi adresiyle erişir.
contract Caller {
    Interact interact;
    // konuşacağımız interact contractının adresini ctor ile veriyoruz
    constructor(address _interactContract) {
        // interact değişkenine yine Interact contractını kullanarak bu adreste bir istance yarat
        interact = Interact(_interactContract);
    }

    // Interact contractındaki callThis fonksiyonunu çağırır
    function callInteract() external {
        interact.callThis();
    }

    // Interact contractındaki address tipindeki caller değişkenini döner
    // çağıran adresi döner
    function readCaller() external view returns (address) {
        return interact.caller(); // parametre olmasına rağmen dışarıdan çağırırken fonksiyon çağırır gibi çağrılır
    }

    // Interact contractındaki uint tipindeki count değişkenini döner
    // x adresinin count değeri kaç bilgisini döner
    function readCallerCount() public view returns (uint256) {
        return interact.counts(msg.sender); // parametre olmasına rağmen dışarıdan çağırırken fonksiyon çağırır gibi çağrılır
    }
    
    function payToPay(address _payAddress) public payable {
        Pay pay = Pay(_payAddress);
        pay.payEth{value: msg.value}(msg.sender);

        // Pay(_payAddress).payEth{value: msg.value}(msg.sender);
    }

    function sendEthByTransfer() public payable {
        payable(address(interact)).transfer(msg.value);
    }
}