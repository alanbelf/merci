import { defineConfig } from 'astro/config';

const isPages = process.env.DEPLOY_TARGET === 'pages';

export default defineConfig({
  site: isPages ? 'https://alanbelf.github.io/merci/' : 'https://merciconcierge.com',
  base: isPages ? '/merci/' : '/',
});
