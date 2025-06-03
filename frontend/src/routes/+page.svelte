<script lang="ts">
    import { getContract } from "../../lib/contract";
    let winner = "";

    async function loadWinner() {
        const contract = await getContract();
        winner = await contract.getWinningProposal();
    }

    loadWinner();
</script>

<main class="p-6 text-center">
    <h1 class="text-3xl font-bold text-blue-700">🏆 Résultat du vote</h1>
    {#if winner}
        <p class="text-xl mt-4">La proposition gagnante est : <strong>{winner}</strong></p>
    {:else}
        <p class="mt-4">Chargement...</p>
    {/if}
</main>
