import hre from "hardhat";

async function main() {
  const Safe = await hre.ethers.getContractFactory("Safe");
  const safeInstance = await Safe.deploy();

  await safeInstance.waitForDeployment();
  const [owner] = await hre.ethers.getSigners();
  console.log("Deploying contract with address:", owner.address);

  const contractAddress = await safeInstane.getAddress();
  console.log(`Contract deployed at: ${contractAddress}`);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
