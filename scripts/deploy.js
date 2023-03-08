// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function deployExhangeContract() {

  // JUST FOR THE POC
  const usdcContractAddress = "0xA2025B15a1757311bfD68cb14eaeFCc237AF5b43";
  const depositAmount = hre.ethers.utils.parseEther("0.000001");

  const Exchange = await hre.ethers.getContractFactory("Exchange");
  const exchange = await Exchange.deploy(usdcContractAddress);

  await exchange.deployed();

  console.log(
    `deployed at ${exchange.address}`
  );
}

deployExhangeContract().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

// 0xd35CCeEAD182dcee0F148EbaC9447DA2c4D449c4