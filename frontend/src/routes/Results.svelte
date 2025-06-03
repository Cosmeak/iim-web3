<script>
    import {onMount} from 'svelte';
    import {fade, scale} from 'svelte/transition';

    // Résultats simulés
    let results = [
        {id: 'vinvin', name: 'Vinvin', percent: 32},
        {id: 'soso', name: 'Soso', percent: 25},
        {id: 'guigui', name: 'Guillaume', percent: 18},
        {id: 'yaya', name: 'Yaya', percent: 14},
        {id: 'toinou', name: 'Toinou', percent: 7},
        {id: 'patpat', name: 'Patpat', percent: 4},
    ];

    // Tri décroissant
    results.sort((a, b) => b.percent - a.percent);

    let showThird = false;
    let showSecond = false;
    let showFirst = false;

    onMount(() => {
        setTimeout(() => (showThird = true), 0);
        setTimeout(() => (showSecond = true), 300);
        setTimeout(() => (showFirst = true), 600);
    });
</script>

<main class="min-h-screen pt-20 px-6 bg-gradient-to-b from-gray-800 to-gray-900 text-white flex flex-col items-center">
    <h1 class="text-3xl md:text-5xl font-bold mb-12" in:fade={{ delay: 100 }}>
        Résultats du vote 🏆
    </h1>

    <!-- Podium -->
    <div class="flex items-end justify-center gap-6 mb-12 w-full max-w-3xl">
        {#if showSecond}
            <div class="flex flex-col items-center" in:fade>
                <div class="text-lg mb-2">{results[1].name}</div>
                <div class="w-24 h-40 bg-gray-700 rounded-t-xl flex items-center justify-center text-2xl font-bold shadow-md">
                    🥈
                </div>
                <span class="mt-2 text-emerald-400 font-semibold">{results[1].percent}%</span>
            </div>
        {/if}

        {#if showFirst}
            <div class="flex flex-col items-center" in:scale={{ duration: 400 }}>
                <div class="text-lg mb-2">{results[0].name}</div>
                <div class="w-24 h-56 bg-yellow-400 text-black rounded-t-xl flex items-center justify-center text-2xl font-bold shadow-lg shadow-yellow-500/50">
                    🥇
                </div>
                <span class="mt-2 text-yellow-300 font-semibold">{results[0].percent}%</span>
            </div>
        {/if}

        {#if showThird}
            <div class="flex flex-col items-center" in:fade>
                <div class="text-lg mb-2">{results[2].name}</div>
                <div class="w-24 h-32 bg-[#cd7f32] rounded-t-xl flex items-center justify-center text-2xl font-bold shadow">
                    🥉
                </div>
                <span class="mt-2 text-orange-300 font-semibold">{results[2].percent}%</span>
            </div>
        {/if}
    </div>

    <!-- Optionnel : autres participants -->
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
