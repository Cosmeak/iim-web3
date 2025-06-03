<script>
    import { fly, fade } from 'svelte/transition';

</script>

<section class="min-h-screen flex flex-col justify-center items-center bg-gradient-to-br from-slate-800 to-slate-900 text-white px-6 pt-16">
    <h1
            class="text-4xl md:text-6xl font-bold text-center mb-6"
            in:fly="{{ y: -40, duration: 800 }}"
    >
        Bienvenue sur <span class="text-emerald-400">VoteOne</span>
    </h1>

    <p
            class="text-lg md:text-xl text-center text-slate-300 mb-10 max-w-xl"
            in:fly="{{ y: 20, duration: 800, delay: 200 }}"
    >
        Une application simple pour voter à choix unique. Choisissez une option, validez, et découvrez les résultats en direct.
    </p>

    <a
            class="bg-emerald-500 hover:bg-emerald-600 text-white font-semibold py-3 px-8 rounded-2xl shadow-lg transition-all duration-300 ease-in-out transform hover:scale-105"
            href="/vote"
            in:fade="{{ delay: 400 }}"
    >
        Commencer
    </a>

    <div
            class="absolute bottom-4 text-sm text-slate-400"
            in:fade="{{ delay: 1000 }}"
    >
        © 2025 - VoteOne
    </div>
</section>
