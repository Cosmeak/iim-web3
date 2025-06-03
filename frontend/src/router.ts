import { createRouter } from "sv-router";
import Home from './routes/Home.svelte';
import Results from "./routes/Results.svelte";
import Vote from "./routes/Vote.svelte";


export const { p, navigate, isActive, route } = createRouter({
    '/': Home,
    '/results': Results,
    '/vote': Vote,
});
