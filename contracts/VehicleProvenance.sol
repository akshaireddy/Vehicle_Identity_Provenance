// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VehicleProvenance {
    struct Vehicle {
        uint256 id;
        string make;
        string model;
        uint256 manufacturingYear;
        address currentOwner;
        uint256 purchaseTimestamp;
        uint256 salePrice;
    }

    mapping(uint256 => Vehicle) public vehicles;
    uint256 public totalVehicles;

    event VehicleRegistered(uint256 indexed id, address indexed owner, uint256 timestamp);
    event VehicleTransferred(uint256 indexed id, address indexed from, address indexed to, uint256 price, uint256 timestamp);

    constructor() {
        totalVehicles = 0;
    }

    function registerVehicle(
        string memory _make,
        string memory _model,
        uint256 _manufacturingYear
    ) external {
        totalVehicles++;
        vehicles[totalVehicles] = Vehicle(
            totalVehicles,
            _make,
            _model,
            _manufacturingYear,
            msg.sender,
            block.timestamp,
            0
        );
        emit VehicleRegistered(totalVehicles, msg.sender, block.timestamp);
    }

    function transferVehicle(uint256 _id, address _newOwner, uint256 _salePrice) external {
        require(_id <= totalVehicles && _id > 0, "Invalid vehicle ID");
        require(vehicles[_id].currentOwner == msg.sender, "You are not the current owner");
        
        vehicles[_id].currentOwner = _newOwner;
        vehicles[_id].purchaseTimestamp = block.timestamp;
        vehicles[_id].salePrice = _salePrice;
        
        emit VehicleTransferred(_id, msg.sender, _newOwner, _salePrice, block.timestamp);
    }

    function getVehicleInfo(uint256 _id) external view returns (
        string memory make,
        string memory model,
        uint256 manufacturingYear,
        address currentOwner,
        uint256 purchaseTimestamp,
        uint256 salePrice
    ) {
        require(_id <= totalVehicles && _id > 0, "Invalid vehicle ID");
        
        Vehicle storage vehicle = vehicles[_id];
        make = vehicle.make;
        model = vehicle.model;
        manufacturingYear = vehicle.manufacturingYear;
        currentOwner = vehicle.currentOwner;
        purchaseTimestamp = vehicle.purchaseTimestamp;
        salePrice = vehicle.salePrice;
    }
}
