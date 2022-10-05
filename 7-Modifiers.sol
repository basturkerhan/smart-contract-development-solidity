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

    function createOrder( string memory _zipCode, uint256[] memory _products ) checkProducts(_products) external returns (uint256) {
        // require(_products.length > 0, "Urun yok"); // artık modifier yapıyor

        // 1. YAZIM
        // Order memory order;
        // order.zipCode = _zipCode;
        // order.customer = msg.sender;
        // order.products = _products;
        // order.status = Status.Taken;
        // orders.push(order);

        // 2. YAZIM
        orders.push(
            Order({
                zipCode: _zipCode,
                customer: msg.sender,
                products: _products,
                status: Status.Taken
            })
        );

        // 3. YAZIM
        // orders.push(Order(msg.sender, _zipCode, _products, Status.Taken));

        return orders.length - 1;
    }

    function advanceOrder(uint256 _orderId) onlyOwner checkOrderId(_orderId) external {
        // require(owner == msg.sender,"Yetkili degilsiniz"); // artık modifier yapıyor
        // require(_orderId < orders.length, "Id mevcut degil"); // artık modifier yapıyor
        
        // burada yapılan değişiklikler fonksiyon bitince de kalmaya devam edecek çünkü storage olarak işaretlendi
        Order storage order = orders[_orderId];
        require(order.status != Status.Shipped, "Order is already shipped");

        if (order.status == Status.Taken)           order.status = Status.Preparing;
        else if (order.status == Status.Preparing)  order.status = Status.Boxed;
        else if (order.status == Status.Boxed)      order.status = Status.Shipped;
    }

    function getOrder(uint256 _orderId) onlyOwner external view returns (Order memory) {
        // require(owner == msg.sender,"Yetkili degilsiniz"); // artık modifier yapıyor
        return  orders[_orderId];
    }

    function updateZip(uint256 _orderId, string memory _zip) checkOrderId(_orderId) onlyCustomer(_orderId) external {
        // require(_orderId < orders.length, "Id mevcut degil"); // artık modifier yapıyor
        Order storage order = orders[_orderId];
        // require(order.customer == msg.sender,"Urun size ait degil"); // artık modifier yapıyor
        order.zipCode = _zip;
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