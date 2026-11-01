# Merci Concierge website

Astro static website for Merci Concierge, Qatar.

## First run

Requirements: Node.js 22 or newer, npm, Git.

```bash
npm install
npm run dev
```

Open the local URL shown by Astro. The helper shortcut is:

```bash
npm run preview:open
```

## Before launch

1. Update contact details and service descriptions in `src/data/site.ts`.
2. Replace testimonial placeholders only with client-approved wording.
3. Verify any Google rating and review count before displaying them; remove them if not verified.
4. Replace sample Unsplash photos with owner-provided or properly licensed commercial images.
5. Confirm all services, claims and wording with the business owner.
6. Check the website on mobile and desktop.

## GitHub Pages deployment

1. Create a GitHub repository named `merci` (e.g. `https://github.com/alanbelf/merci`). The local folder is `merci_concierge`; the repository name is `merci`.
2. Push this project to the repository's `main` branch.
3. In `astro.config.mjs`, set `site` to `https://alanbelf.github.io/merci/` and `base` to `/merci/` (the repository name).
4. In GitHub, open **Settings → Pages** and set the build/deployment source to **GitHub Actions**.
5. The included workflow is manual. Run it from **Actions → Deploy Astro site to GitHub Pages → Run workflow**.
6. The site should be available at `https://alanbelf.github.io/merci/`.

GitHub Pages availability and terms depend on the repository visibility and GitHub plan. A public repository is the simplest option for a free public site.

## Approval and publishing scripts

- `npm run approve`: runs checks, asks for explicit approval, commits and pushes to `main`.
- `npm run publish`: deploys only the last approved commit using GitHub CLI.
- `npm run rollback`: creates a revert commit to undo the current commit and deploys it.

Install GitHub CLI and authenticate with `gh auth login` before using publish/rollback. These scripts are guardrails, not a substitute for reviewing changes. Keep a normal GitHub backup and verify every deployment.

## Codex

Open this repository in Codex. It reads `AGENTS.md`. See `.codex/README.md` for suggested local actions. Codex should edit and check changes, but must not commit or publish without the owner's explicit approval.

## Known limitations

- Contact details and testimonials are placeholders.
- The initial photos are remote sample images, not confirmed licensed business assets.
- This starter has no booking engine or contact form backend; the contact call to action uses email.
- The first local build must be validated on the owner's Mac before deployment.
