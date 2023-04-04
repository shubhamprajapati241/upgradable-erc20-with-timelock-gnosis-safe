const { ethers, upgrades } = require("hardhat");

async function main() {
  const ERC20TokenV1 = await ethers.getContractFactory("ERC20TokenV1");
  const erc20TokenV1 = await upgrades.deployProxy(ERC20TokenV1, [1000000]);
  await erc20TokenV1.deployed();

  const implementationAddress = await upgrades.erc1967.getImplementationAddress(
    erc20TokenV1.address
  );

  console.log(
    "ERC20TokenV1 contract deployed at address: " + erc20TokenV1.address
  );
  console.log(
    "implementation contract deployed at address: " + implementationAddress
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
