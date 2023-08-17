import { ethers } from "hardhat";
// const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await ethers.getSigners();
  // const contractAddress = process.env.CONTRACT_ADDRESS;
  // const newAddress = process.env.NEW_OWNER_ADDRESS;


  const VehicleProvenance = await ethers.getContractFactory("VehicleProvenance");
  const vehicleProvenance = await VehicleProvenance.attach("0x9cB623367712107134541b2ab602D26C8e8D3eFd");

  // Interact with the contract

  // Register a new vehicle
  await vehicleProvenance.registerVehicle("Toyota", "Camry", 2022);

  // Transfer a vehicle to a new owner
  await vehicleProvenance.transferVehicle(1, "0xf39fd6e51aad88f6f4ce6ab8827279cfffb92266", ethers.utils.parseEther("100"));

  // Get information about a vehicle
  const vehicleInfo = await vehicleProvenance.getVehicleInfo(1);
  console.log("Vehicle Info:", vehicleInfo);

  // Print the current owner of the vehicle
  console.log("Current Owner:", vehicleInfo.currentOwner);

  // Print the total number of registered vehicles
  const totalVehicles = await vehicleProvenance.totalVehicles();
  console.log("Total Vehicles:", totalVehicles.toString());
}

main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});

