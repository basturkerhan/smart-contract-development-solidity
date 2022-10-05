pragma solidity ^0.8.0;

contract Variables {
    // Fixed Size Types
    bool isTrue = true;
    int number = 12; // int256 => -2^256 ve 2^256
    int8 number2 = 12;
    uint number3 = 12; // 0 ve 2^256

    address myAdress = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4; // 20 byte
    bytes32 name = "erhan";

    // Dynamic Size Types
    string metin = "deneme metin";
    bytes dinamikBytes = "deneme metin";
    uint[] sayiArray = [1,2,3,4,5];

    mapping(uint => address) public liste1; // anahtar kelime tutucu

    // User Defined Types
    struct Human {
        uint ID;
        string name;
        string surname;
        uint age;
    }

    Human person1;
    person1.Name = "Erhan";
    mapping(uint => Human) public liste2;

    enum Light {
        RED,
        YELLOW,
        GREEN
    }
    // Light.RED;


    // 1 wei = 1;
    // 1 ether = 10^9 gwei;
    // 1 ether = 10^18 wei;
    
    // 1 = 1 seconds;
    // 1 minutes = 60 seconds;

    // state variables
    string public veri = "deneme";
    

    // function show() public view returns(string memory) {
    //     return veri;
    // } 

    function show() public pure returns(uint) {
        return 17;
    }

    function returnBlockNumber() public pure returns(uint) {
        // block.difficulty;
        // block.gaslimit;
        // block.timestamp;
        // msg.sender;
        // msg.value; // gönderilen verinin değeri
        // msg.data; // data gönderme
        return block.number;
    }

}