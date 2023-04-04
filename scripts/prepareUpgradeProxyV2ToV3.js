const { ethers, upgrades } = require("hardhat");

async function main() {
  const proxyAddress = "0x6eE935B6B58A428Fd550b9F38D63d9b80E013D35";
  // This is the proxy address NOT the admin of the proxy.

  const ERC20TokenV3 = await ethers.getContractFactory("ERC20TokenV3");
  console.log("Preparing upgrade...");
  const erc20TokenV3 = await upgrades.prepareUpgrade(
    proxyAddress,
    ERC20TokenV3
  );
  console.log("ERC20TokenV3 at:", erc20TokenV3);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
