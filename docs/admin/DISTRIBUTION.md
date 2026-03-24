# Course Distribution — Admin Guide

## How Students Get the Course

### Primary: One-Line Install Command

Students paste this into their Terminal:

```
curl -fsSL https://raw.githubusercontent.com/Larksa/100-Days-Agentic-Engineering/main/setup.sh | bash -s -- --install
```

This clones the repo and runs `setup.sh` which:
1. Creates the `projects/` folder
2. Creates `progress.json` with empty state
3. Sets all course files (`days/`, `CLAUDE.md`, `README.md`) to read-only
4. Leaves `projects/` and `progress.json` writable

### Fallback: ZIP Download

Students download from GitHub Releases:
`https://github.com/Larksa/100-Days-Agentic-Engineering/releases/latest`

They unzip and run `bash setup.sh` manually. **Note:** ZIP downloads don't have `.git/`, so `update-course.sh` will detect this and tell them to re-download instead.

---

## Releasing Updates

### When You Edit Course Content

```bash
# 1. Make your changes to days/, CLAUDE.md, etc.
# 2. Commit
git add -A
git commit -m "feat: improve Day 3 iteration section"

# 3. Push to GitHub
git push origin main
```

Students who installed via the one-line command can then run:
```bash
bash update-course.sh
```

### When You Add New Days

1. Create `days/day-XX.md` following the existing format
2. Create `days/day-XX-preview.html` with the animated preview
3. Update the "Available Days" section in `CLAUDE.md` if needed
4. Commit and push

```bash
git add days/day-12.md days/day-12-preview.html CLAUDE.md
git commit -m "feat: add Day 12 — [project name]"
git push origin main
```

### Creating a New GitHub Release

Do this for major milestones (new phase, batch of new days) so ZIP downloaders get an updated version:

```bash
gh release create v1.1 --title "Phase 1: Days 1-12" --notes "Added Day 12: [project name]"
```

---

## How Updates Work for Students

### Git-Installed Students (one-line command)

1. Student runs `bash update-course.sh`
2. Script temporarily unlocks read-only course files
3. Runs `git pull origin main --ff-only`
4. Re-locks course files to read-only (via EXIT trap — always runs, even on failure)
5. Student's `projects/` and `progress.json` are **never touched** (gitignored)

### ZIP-Downloaded Students

1. Student runs `bash update-course.sh`
2. Script detects no `.git/` directory
3. Tells them to re-download from GitHub Releases
4. Student copies their `projects/` folder and `progress.json` to the new download

---

## Troubleshooting

### Student says "Permission denied" when trying to edit course files

**This is working as intended!** The setup script makes course files read-only. If they need to know why: "These files are the course materials — they're protected so you can receive updates without conflicts. Your projects go in the `projects/` folder."

### Student's update-course.sh fails

Most likely cause: they somehow modified a course file. Fix:
```bash
chmod -R u+w days/ CLAUDE.md README.md
git checkout -- days/ CLAUDE.md README.md
bash update-course.sh
```

### Student lost their progress.json

They can create a fresh one:
```bash
echo '{"last_completed": 0, "days_completed": [], "days_started": []}' > progress.json
```
Or just tell Claude Code which day they're on — it will recreate the file.

### Student wants to start completely fresh

```bash
rm -rf projects/*
rm progress.json
bash setup.sh
```

### Testing before release

Always run the test suite before pushing updates:
```bash
bash tests/test-setup.sh
```

---

## Architecture Notes

### What's Protected (read-only for students)
- `days/*.md` — Day instructions (read by Claude Code)
- `days/*-preview.html` — Animated previews (opened in browser)
- `CLAUDE.md` — Teaching instructions (read by Claude Code)
- `README.md` — Getting started guide

### What Students Own (read-write)
- `projects/` — All project code created during sessions
- `progress.json` — Tracks completed/started days

### What's Gitignored (never committed)
- `projects/*` (except `.gitkeep`)
- `progress.json`
- `.DS_Store`
- `tests/tmp/`
