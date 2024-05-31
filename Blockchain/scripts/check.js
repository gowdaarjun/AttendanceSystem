const { ethers } = require("hardhat");

async function main() {
  const provider = new ethers.providers.JsonRpcProvider("https://volta.network.rpc.url");
  const balance = await provider.getBalance("0x2bbe50DDfE077837701213C44ABbe298fDE5f72d");
  console.log(`Balance: ${ethers.utils.formatEther(balance)} ETH`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
