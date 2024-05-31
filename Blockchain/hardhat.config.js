require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
    solidity: "0.8.11",
    defaultNetwork: "volta",
    networks: {
        hardhat: {},
        volta: {
            url: API_URL,
            accounts: [PRIVATE_KEY],
            gas: 50000,
            gasPrice: 0 // Set gas price to 0 to accept any gas price
        }
    }
};
