const { ethers } = require("hardhat");
require("dotenv").config();

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const VehicleProvenance = await ethers.getContractFactory("VehicleProvenance");
  const vehicleProvenance = await VehicleProvenance.deploy();

  console.log("VehicleProvenance address:", vehicleProvenance.address);
}

main().then(() => process.exit(0)).catch(error => {
  console.error(error);
  process.exit(1);
});
