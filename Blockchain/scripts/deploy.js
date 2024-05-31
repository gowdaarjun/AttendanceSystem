require('dotenv').config();
const hre = require("hardhat");

async function main() {
    // Compile the contract if not already compiled
    await hre.run('compile');

    const [deployer] = await hre.ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Get the current nonce for the deployer account
    const nonce = await hre.ethers.provider.getTransactionCount(deployer.address, 'latest');

    // Get the contract to deploy
    const CanteenManagement = await hre.ethers.getContractFactory("CanteenManagement");

    const txOptions = {
        nonce: nonce,
        gasLimit: 2100000,  // you can adjust this value if needed
        gasPrice: hre.ethers.utils.parseUnits('1', 'gwei')  // setting a gas price
    };

    const canteenManagement = await CanteenManagement.deploy(txOptions);

    await canteenManagement.deployed();

    console.log("CanteenManagement deployed to:", canteenManagement.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
