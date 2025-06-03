import { ethers } from "hardhat";

async function main() {
  const proposals = ["Alice", "Bob", "Charlie"];
  const bytes32Proposals = proposals.map((name) =>
      ethers.encodeBytes32String(name)
  );

  const Ballot = await ethers.getContractFactory("Ballot");
  const ballot = await Ballot.deploy(bytes32Proposals);

  await ballot.waitForDeployment();
  const [owner] = await ethers.getSigners();

  console.log("Deploying contract with address:", owner.address);
  console.log(`Contract deployed at: ${await ballot.getAddress()}`);
}

main().catch((err) => {
  console.error(err);
  process.exitCode = 1;
});
