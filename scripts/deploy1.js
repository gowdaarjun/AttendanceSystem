const hre = require("hardhat");

async function main() {
  // Compile the contract if not already compiled
  await hre.run('compile');

  // Get the contract to deploy
  const CanteenManagement = await hre.ethers.getContractFactory("CanteenManagement");
  const canteenManagement = await CanteenManagement.deploy();

  await canteenManagement.deployed();

  console.log("CanteenManagement deployed to:", canteenManagement.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
