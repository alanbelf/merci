# Merci Concierge — Codex working instructions

## Purpose
Maintain a polished, simple marketing website for a one-person concierge business in Qatar. The site is built with Astro and hosted on Hostinger at https://merciconcierge.com. Every push to `main` is validated, built and deployed automatically by GitHub Actions.

The person you talk to is usually the business owner, who is not a developer. Reply in the language the owner writes in, in plain words, without jargon.

## Rules
- Make small, focused changes. Do not redesign the whole site unless explicitly asked.
- Keep the site static. Do not add databases, accounts, forms requiring a backend, analytics, or paid services without explicit approval.
- Edit business copy and contact details in `src/data/site.ts` where possible. Images live in `src/assets`.
- Never invent phone numbers, email addresses, prices, service promises, client names, testimonials, review counts, ratings, or credentials.
- Use the official WhatsApp number `+974 7072 2800`; keep contact details centralised in `src/data/site.ts`.
- Preserve genuine testimonials exactly as supplied, including reviewer names and original review links. Never invent or paraphrase customer reviews.
- Do not publish private client information.
- Use only images supplied by the owner or images whose usage rights are clear. Do not assume a random online image is licensed for commercial use.
- Preserve accessibility, mobile responsiveness, and existing visual style.
- Support the Warm Ivory and Midnight Doha themes, persist the visitor's choice, and keep theme controls accessible.
- After relevant layout or style changes, check both themes at desktop and mobile widths, including fixed contact controls.
- Avoid adding dependencies unless there is a clear need.

## Files you must not change
Do not edit, unless the technical maintainer explicitly asks: `.github/`, `scripts/`, `astro.config.mjs`, `package.json`, `package-lock.json`, `public/.htaccess`, `AGENTS.md`. Never read, print or commit secrets, passwords, FTP details or `.env` files. If a request needs one of these files, explain why and ask the owner to contact the technical maintainer.

## Workflow
1. Understand the requested change and inspect the relevant files.
2. Make the smallest reasonable edit.
3. Run `npm run check:all`.
4. Start the local preview with `npm run dev` and tell the owner the address to open (usually http://localhost:4321) and exactly what to look at.
5. Report changed files, checks performed, and anything the owner must verify. Nothing is online yet at this point.
6. **Publishing.** Never publish on your own initiative. Only when the owner clearly asks to publish after seeing the preview (for example "publish" or "mets en ligne"), run `./scripts/publish.sh "<short description of the change>"`. Do not run `git add`, `git commit` or `git push` yourself.
7. **Undo.** Only when the owner clearly asks to undo the last update, run `./scripts/rollback.sh` without `--yes` first so it shows which update would be undone, tell the owner, and wait for a clear confirmation in the chat. Then run `./scripts/rollback.sh --yes`.
8. Never use other git commands that change history or branches (`reset`, `rebase`, `checkout`, `switch`, `branch`, `--force`).
9. Never claim that a change is online unless the script output says the deployment succeeded. If it only says the deployment started or could not be followed, say so and ask the owner to check https://merciconcierge.com. If a script fails, show its message and stop; do not try to work around it.

## Content caution
Do not publish contact placeholders, unverified ratings, review counts, or customer information. Replace stock photography only with owner-provided or properly licensed images.
