<script>
    import {onMount} from 'svelte';
    import {ethers} from 'ethers';
    import {fade, scale} from 'svelte/transition';
    import contractABI from '../abis/ballot.json';

    const CONTRACT_ADDRESS = '0x5FbDB2315678afecb367f032d93F642f64180aa3';

    let results = [];
    let showThird = false;
    let showSecond = false;
    let showFirst = false;

    // Fonction qui anime l'affichage du podium
    function showPodium() {
        showThird = false;
        showSecond = false;
        showFirst = false;
        setTimeout(() => (showThird = true), 0);
        setTimeout(() => (showSecond = true), 300);
        setTimeout(() => (showFirst = true), 600);
    }

    // Met à jour la liste des résultats avec pourcentages calculés et triés
    function updateResults(newResults) {
        const totalVotes = newResults.reduce(
            (acc, cur) => acc + cur.votes.toNumber(),
            0
        );

        results = newResults.map((r) => ({
            id: r.id,
            name: r.name,
            percent: totalVotes > 0 ? Math.round((r.votes.toNumber() / totalVotes) * 100) : 0,
        }));

        results.sort((a, b) => b.percent - a.percent);
        showPodium();
    }

    // Récupère les résultats du contrat
    async function fetchResults() {
        if (!window.ethereum) {
            alert('Veuillez installer Metamask ou un autre wallet compatible.');
            return;
        }

        const provider = new ethers.BrowserProvider(window.ethereum);
        const contract = new ethers.Contract(CONTRACT_ADDRESS, contractABI.abi, provider);

        try {
            const data = await contract.getAllProposals()

            console.log('Données brutes reçues du contrat :', data);

            // Adaptation selon la structure de data
            const formatted = data.map((item, index) => {
                let name, votes;
                if (Array.isArray(item)) {
                    name = item[0];
                    votes = ethers.BigNumber.from(item[1]);
                } else {
                    name = item.name;
                    votes = ethers.BigNumber.from(item.votes);
                }
                return {
                    id: 'id-' + index,
                    name,
                    votes,
                };
            });

            updateResults(formatted);
        } catch (e) {
            console.error('Erreur récupération résultats:', e);
            alert('Erreur lors de la récupération des résultats. Vérifie la console.');
        }
    }

    onMount(() => {
        fetchResults();
    });
</script>

<main
        class="min-h-screen pt-20 px-6 bg-gradient-to-b from-gray-800 to-gray-900 text-white flex flex-col items-center"
>
    <h1 class="text-3xl md:text-5xl font-bold mb-12" in:fade={{ delay: 100 }}>
        Résultats du vote 🏆
    </h1>

    <!-- Podium -->
    <div class="flex items-end justify-center gap-6 mb-12 w-full max-w-3xl">
        {#if showSecond && results.length > 1}
            <div class="flex flex-col items-center" in:fade>
                <div class="text-lg mb-2">{results[1].name}</div>
                <div
                        class="w-24 h-40 bg-gray-700 rounded-t-xl flex items-center justify-center text-2xl font-bold shadow-md"
                >
                    🥈
                </div>
                <span class="mt-2 text-emerald-400 font-semibold">{results[1].percent}%</span>
            </div>
        {/if}

        {#if showFirst && results.length > 0}
            <div class="flex flex-col items-center" in:scale={{ duration: 400 }}>
                <div class="text-lg mb-2">{results[0].name}</div>
                <div
                        class="w-24 h-56 bg-yellow-400 text-black rounded-t-xl flex items-center justify-center text-2xl font-bold shadow-lg shadow-yellow-500/50"
                >
                    🥇
                </div>
                <span class="mt-2 text-yellow-300 font-semibold">{results[0].percent}%</span>
            </div>
        {/if}

        {#if showThird && results.length > 2}
            <div class="flex flex-col items-center" in:fade>
                <div class="text-lg mb-2">{results[2].name}</div>
                <div
                        class="w-24 h-32 bg-[#cd7f32] rounded-t-xl flex items-center justify-center text-2xl font-bold shadow"
                >
                    🥉
                </div>
                <span class="mt-2 text-orange-300 font-semibold">{results[2].percent}%</span>
            </div>
        {/if}
    </div>

    <!-- Autres participants -->
    <div class="flex flex-col gap-4 w-full max-w-2xl">
        {#each results.slice(3) as person, index (person.id)}
            <div
                    class="bg-gray-700 rounded-xl px-6 py-4 flex items-center justify-between shadow-md relative overflow-hidden"
                    in:fade={{ delay: 700 + index * 100 }}
            >
                <div class="flex items-center gap-4">
                    <span class="text-xl font-semibold">{index + 4}.</span>
                    <span class="text-lg md:text-xl">{person.name}</span>
                </div>
                <div class="text-right font-bold text-emerald-400 text-xl">{person.percent}%</div>
                <div
                        class="absolute left-0 top-0 h-full bg-emerald-500/20 -z-10 rounded-xl"
                        style="width: {person.percent}%"
                />
            </div>
        {/each}
    </div>
</main>
