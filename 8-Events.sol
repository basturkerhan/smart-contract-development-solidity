// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

contract StructEnum {

    enum Status {
        Taken,
        Preparing,
        Boxed,
        Shipped
    }

    struct Order {
        address customer;
        string zipCode;
        uint256[] products;
        Status status;
    }

    Order[] public orders;
    address private immutable owner;

    constructor() {
        owner = msg.sender; // kontratı oluşturan kişiyi sahip yaptık
    }


    // EVENTS------------------------------
    event OrderCreated(uint256 _orderId, address indexed _consumer);
        // indexed verilen bir değişken daha sonra blockchainden tekrar sorgulanabilir
        // mesela bir kullanıcının geçmişe dönük yaptığı transectionları sorgulama yapılabilir

    // bu eventi ekleme amacımız da sonrasında adres değişikliği olup olmadığını bu eventi dinleyerek bulacağız
    event ZipChanged(uint256 _orderId, string _zipCode);

    function createOrder( string memory _zipCode, uint256[] memory _products ) checkProducts(_products) external returns (uint256) {
        orders.push(
            Order({
                zipCode: _zipCode,
                customer: msg.sender,
                products: _products,
                status: Status.Taken
            })
        );

        emit OrderCreated(orders.length - 1, msg.sender);

        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) onlyOwner checkOrderId(_orderId) external {
        // burada yapılan değişiklikler fonksiyon bitince de kalmaya devam edecek çünkü storage olarak işaretlendi
        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped");

        if (order.status == Status.Taken)           order.status = Status.Preparing;
        else if (order.status == Status.Preparing)  order.status = Status.Boxed;
        else if (order.status == Status.Boxed)      order.status = Status.Shipped;
    }

    function getOrder(uint256 _orderId) onlyOwner external view returns (Order memory) {
        return  orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) checkOrderId(_orderId) onlyCustomer(_orderId) external {
        Order storage order = orders[_orderId];
        order.zipCode = _zip;
        emit ZipChanged(_orderId, _zip);
    } 

    // MODIFIERS-----------------------------------------------------------------
    modifier onlyOwner {
         require(owner == msg.sender,"Yetkili degilsiniz"); // kullanmaya çalışan kişi kontrat yetkilisi mi
         _; // çağıran fonksiyonun body sini temsil eder. Burada require yapılıp sonra body ye girilecek 
    }

    modifier onlyCustomer(uint256 _orderId) {
        require(orders[_orderId].customer == msg.sender,"Urun size ait degil");
        _;
    }

    modifier checkProducts(uint256[] memory _products) {
         require(_products.length > 0, "Urun yok");
         _;
    }

    modifier checkOrderId(uint256 _orderId) {
        require(_orderId < orders.length, "Id mevcut degil");
        _;
    }


}