// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CanteenManagement {
    address public owner;

    struct Item {
        string name;
        uint price;
        bool available;
    }

    struct Order {
        uint[] itemIds;
        uint totalAmount;
        bool completed;
    }

    Item[] public menu;
    mapping(address => Order[]) public orders;

    event ItemAdded(uint itemId, string name, uint price);
    event OrderPlaced(address indexed user, uint orderId, uint totalAmount);
    event OrderCompleted(address indexed user, uint orderId);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }

    modifier validItemId(uint itemId) {
        require(itemId < menu.length, "Invalid item ID");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function addItem(string memory _name, uint _price) public onlyOwner {
        menu.push(Item({
            name: _name,
            price: _price,
            available: true
        }));
        emit ItemAdded(menu.length - 1, _name, _price);
    }

    function updateItemAvailability(uint _itemId, bool _available) public onlyOwner validItemId(_itemId) {
        menu[_itemId].available = _available;
    }

    function placeOrder(uint[] memory _itemIds) public payable {
        uint totalAmount = 0;

        for (uint i = 0; i < _itemIds.length; i++) {
            uint itemId = _itemIds[i];
            require(itemId < menu.length, "Item does not exist");
            require(menu[itemId].available, "Item not available");

            totalAmount += menu[itemId].price;
        }

        require(msg.value >= totalAmount, "Insufficient payment");

        orders[msg.sender].push(Order({
            itemIds: _itemIds,
            totalAmount: totalAmount,
            completed: false
        }));

        emit OrderPlaced(msg.sender, orders[msg.sender].length - 1, totalAmount);

        // Refund any excess amount sent
        if (msg.value > totalAmount) {
            payable(msg.sender).transfer(msg.value - totalAmount);
        }
    }

    function completeOrder(address _user, uint _orderId) public onlyOwner {
        require(_orderId < orders[_user].length, "Invalid order ID");
        require(!orders[_user][_orderId].completed, "Order already completed");

        orders[_user][_orderId].completed = true;

        emit OrderCompleted(_user, _orderId);
    }

    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }

    function getMenu() public view returns (Item[] memory) {
        return menu;
    }

    function getOrders(address _user) public view returns (Order[] memory) {
        return orders[_user];
    }
}
