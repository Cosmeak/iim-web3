<script lang="ts">
    import { onMount } from 'svelte';
    import {
        connectWallet,
        getProposals,
        register,
        vote,
        getWinningProposal,
        isRegistered,
        hasVoted
    } from './lib/contract';

    let account = '';
    let proposals: string[] = [];
    let registered = false;
    let voted = false;
    let winner: string = '';

    onMount(async () => {
        account = await connectWallet();
        proposals = await getProposals();
        registered = await isRegistered(account);
        voted = await hasVoted(account);
    });

    async function handleRegister() {
        await register();
        registered = true;
    }

    async function handleVote(index: number) {
        await vote(index);
        voted = true;
    }

    async function checkWinner() {
        const index = await getWinningProposal();
        winner = proposals[index];
    }
</script>

<main>
    <h1>Système de Vote Web3</h1>
    <p>🧾 Adresse connectée : {account}</p>

    {#if !registered}
        <button on:click={handleRegister}>📝 S'inscrire</button>
    {:else if voted}
        <p>✅ Vous avez déjà voté</p>
    {:else}
        <h2>📋 Propositions :</h2>
        {#each proposals as p, i}
            <button on:click={() => handleVote(i)}>{p}</button>
        {/each}
    {/if}

    <hr />
    <button on:click={checkWinner}>🎯 Voir le gagnant</button>
    {#if winner}
        <p>🏆 Gagnant : {winner}</p>
    {/if}
</main>

<style>
    main {
        font-family: sans-serif;
        padding: 2rem;
    }

    button {
        margin: 0.5rem;
        padding: 0.5rem 1rem;
        font-size: 1rem;
        cursor: pointer;
    }

    hr {
        margin: 2rem 0;
    }
</style>
