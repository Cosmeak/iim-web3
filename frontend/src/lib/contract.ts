import { ethers } from "ethers";
import abi from '../contracts/Voting.json';
import VotingABI from "../contracts/Voting.json";
import { VOTING_CONTRACT_ADDRESS } from "./constants";

let contract: ethers.Contract;
let signer: ethers.Signer;
let provider: ethers.BrowserProvider;

export async function connectWallet(): Promise<string> {
    provider = new ethers.BrowserProvider(window.ethereum);
    await provider.send("eth_requestAccounts", []);
    signer = await provider.getSigner();
    contract = new ethers.Contract(VOTING_CONTRACT_ADDRESS, abi.abi, signer);
    return await signer.getAddress(); // OK, car c'est une adresse directe
}


export async function getProposals(): Promise<string[]> {
    const count = await contract.getProposalCount();
    const names: string[] = [];
    for (let i = 0; i < count; i++) {
        const [name] = await contract.getProposal(i);
        names.push(name);
    }
    return names;
}

export async function register(): Promise<void> {
    const tx = await contract.register();
    await tx.wait();
}

export async function vote(index: number): Promise<void> {
    const tx = await contract.vote(index);
    await tx.wait();
}

export async function getWinningProposal(): Promise<number> {
    return await contract.getWinningProposal();
}

export async function isRegistered(address: string): Promise<boolean> {
    return await contract.isRegistered(address);
}

export async function hasVoted(address: string): Promise<boolean> {
    return await contract.hasVoted(address);
}

export async function getContract() {
    if (!window.ethereum) throw new Error("MetaMask non detecté");
    await window.ethereum.request({ method: "eth_requestAccounts" });

    const provider = new ethers.BrowserProvider(window.ethereum);
    const signer = await provider.getSigner();

    const contract = new ethers.Contract(
        VOTING_CONTRACT_ADDRESS,
        VotingABI.abi,
        signer
    );

    return contract;
}