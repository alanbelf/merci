# Codex setup

Open this repository in the Codex desktop app. Codex reads the repository-level `AGENTS.md` for project guidance.

You can configure local actions in the Codex app's local-environment settings. Suggested commands:

- Preview website: `npm run preview:open`
- Check and approve changes: `npm run approve`
- Publish approved version: `npm run publish`
- Roll back last deployment: `npm run rollback`

Actions are convenience shortcuts, not a security boundary. The scripts run in a terminal and may ask for confirmation. Review Codex's changes before approving them.
