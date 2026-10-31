# Merci Concierge — Codex working instructions

## Purpose
Maintain a polished, simple marketing website for a one-person concierge business in Qatar. The site is built with Astro and deployed to GitHub Pages.

## Rules
- Make small, focused changes. Do not redesign the whole site unless explicitly asked.
- Keep the site static. Do not add databases, accounts, forms requiring a backend, analytics, or paid services without explicit approval.
- Edit business copy and contact details in `src/data/site.ts` where possible.
- Never invent phone numbers, email addresses, prices, service promises, client names, testimonials, review counts, ratings, or credentials.
- Do not publish private client information.
- Use only images supplied by the owner or images whose usage rights are clear. Do not assume a random online image is licensed for commercial use.
- Preserve accessibility, mobile responsiveness, and existing visual style.
- Avoid adding dependencies unless there is a clear need.

## Workflow
1. Understand the requested change and inspect the relevant files.
2. Make the smallest reasonable edit.
3. Run `npm run check:all`.
4. Report changed files, checks performed, and anything the owner must verify.
5. Do not stage, commit, push, publish, or roll back. The owner handles approval and publishing using the documented scripts.
6. Never claim that a change is published unless the owner confirms the deployment succeeded.

## Content caution
The current contact details and testimonial text are placeholders. The displayed rating and review count must be checked and either verified or removed before launch. Replace stock photography with owner-provided or properly licensed images.
