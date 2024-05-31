// scripts/deploy.js

const { ethers } = require("hardhat"); // Import ethers from hardhat instead of directly
const fs = require('fs');

async function main() {
    const AttendanceSystem = await ethers.getContractFactory("AttendanceSystem");
    const attendanceSystemInstance = await AttendanceSystem.deploy();

    console.log("Contract deployed to address:", attendanceSystemInstance.address);

    // Save deployed contract address to a file for later reference
    const contractAddress = attendanceSystemInstance.address;
    fs.writeFileSync("deployed_contract_address.txt", contractAddress);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error("Error deploying contract:", error);
        process.exit(1);
    });
