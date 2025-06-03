<script>
    import { isActive } from '../router.js';
</script>

<header class="flex w-full items-center justify-between bg-gray-900 p-4 text-white shadow-lg fixed top-0 z-50 h-16">
    <div class="flex items-center space-x-6">
        <a href="/" class="relative text-lg font-bold tracking-wide group"
           class:text-emerald-400={isActive('/')}> <!-- Use isActive to conditionally apply class -->
            VoteOne
            <span class="absolute left-0 -bottom-1 h-0.5 w-0 bg-emerald-400 transition-all duration-300 group-hover:w-full"
                class:w-full={isActive('/')}
            ></span>
        </a>
        <a href="/vote" class="relative text-lg tracking-wide group"
              class:text-emerald-400={isActive('/vote')}> <!-- Use isActive to conditionally apply class -->
            Vote
            <span class="absolute left-0 -bottom-1 h-0.5 w-0 bg-emerald-400 transition-all duration-300 group-hover:w-full"
                class:w-full={isActive('/vote')}
            ></span>
        </a>
        <a href="/results" class="relative text-lg tracking-wide group"
                class:text-emerald-400={isActive('/results')}> <!-- Use isActive to conditionally apply class -->
            Results
            <span class="absolute left-0 -bottom-1 h-0.5 w-0 bg-emerald-400 transition-all duration-300 group-hover:w-full"
                class:w-full={isActive('/results')}
            ></span>
        </a>
    </div>
</header>
