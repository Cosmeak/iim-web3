import { ethers } from "hardhat";
import * as dotenv from "dotenv";

dotenv.config(); // Charge .env si tu déploies sur Sepolia

async function main() {
  const proposals = ["Alice", "Bob", "Charlie"];
  const maxVoters = 5;

  console.log("Deploiement du contrat Voting...");

  const Voting = await ethers.getContractFactory("Voting");
  const voting = await Voting.deploy(
      proposals.map(name => ethers.encodeBytes32String(name)),
      maxVoters
  );

  await voting.waitForDeployment();

  console.log("✅ Contrat deployé a :", await voting.getAddress());

  // Vérification initiale (optionnel)
  const prop0 = await voting.getProposal(0);
  console.log("🎯 Premiere proposition :", ethers.decodeBytes32String(prop0.name));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
