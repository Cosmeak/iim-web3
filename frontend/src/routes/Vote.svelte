<script>
    import { fly, scale, fade } from 'svelte/transition';
    import { tick } from 'svelte';
    import { navigate } from '../router';

    const choices = [
        { id: 'soso', label: 'Soso' },
        { id: 'toinou ', label: 'Toinou' },
        { id: 'guigui', label: 'Guigui' },
        { id: 'yaya', label: 'Yaya' },
        { id: 'patpat', label: 'Patpat' },
        { id: 'vinvin', label: 'Vinvin' },
    ];

    let selected = null;
    let hasVoted = false;

    async function submitVote() {
        if (!selected || hasVoted) return;

        hasVoted = true;
        await tick();

        // Simuler une transition vers les résultats
        setTimeout(() => {
            navigate('/results');
        }, 1200);
    }
</script>

<main class="min-h-screen pt-20 px-6 bg-gradient-to-b from-gray-900 to-gray-800 text-white flex flex-col items-center pt-16">
    <h1 class="text-3xl md:text-5xl font-bold mb-8" in:fly={{ y: -30 }}>
        Votez pour votre personne préférée du groupe ✨
    </h1>

    <div class="grid gap-4 w-full max-w-md">
        {#each choices as choice (choice.id)}
            <button
                    class="flex items-center justify-between w-full p-4 rounded-xl border transition-all duration-300
                bg-gray-700 hover:bg-emerald-600 hover:scale-[1.02]
                cursor-pointer shadow-lg
                {selected === choice.id ? 'bg-emerald-500 border-emerald-400 scale-[1.03]' : 'border-gray-600'}"
                    on:click={() => selected = choice.id}
                    in:fade
            >
                <span class="text-lg">{choice.label}</span>
                {#if selected === choice.id}
          <span class="text-sm text-white bg-emerald-700 px-2 py-1 rounded-full" in:scale>
            Sélectionné
          </span>
                {/if}
            </button>
        {/each}
    </div>

    <button
            class="mt-10 bg-emerald-500 hover:bg-emerald-600 text-white font-semibold py-3 px-8 rounded-full shadow-xl transition-all duration-300 ease-in-out disabled:opacity-50 disabled:cursor-not-allowed"
            on:click={submitVote}
            disabled={!selected || hasVoted}
            in:fade={{ delay: 200 }}
    >
        {#if hasVoted}
            ✅ Merci pour votre vote !
        {:else}
            Valider mon choix
        {/if}
    </button>
</main>
