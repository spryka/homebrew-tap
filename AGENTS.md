# Homebrew tap

Personal project; no Tracker task key is required.

- Keep recipes in Casks/. Use versioned immutable archives and real SHA-256 hashes.
- Never commit credentials, signing keys or app archives to this Git repository.
- Preserve macOS Gatekeeper and quarantine checks. Do not reset permissions or delete user data.
- Refuse replacing a running Meeting Companion. Preserve Apple Silicon/macOS requirements.
- Validate changed recipes with brew style and brew fetch; test install/upgrade without an active recording.
- Update README when installation or authentication changes.
