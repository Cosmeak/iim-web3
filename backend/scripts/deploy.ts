import { ethers } from "hardhat";

async function main() {
  const Contract = await ethers.getContractFactory("Ballot");
  const contractInstance = await Contract.deploy();

  await contractInstance.waitForDeployment();
  const [owner] = await ethers.getSigners();
  console.log("Deploying contract with address:", owner.address);

  const contractAddress = await contractInstane.getAddress();
  console.log(`Contract deployed at: ${contractAddress}`);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
