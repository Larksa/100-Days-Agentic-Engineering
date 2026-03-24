# Course Distribution & Access Control Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a beginner-friendly distribution system where the admin can push course updates and students cannot modify course files — without students needing any knowledge of Git or GitHub.

**Architecture:** The course repo lives on GitHub (admin-controlled). Students get the course via a one-line terminal command (primary) or ZIP download (fallback). A `setup.sh` script makes course files read-only on the student's machine. An `update-course.sh` script wraps `git pull` so students can receive updates with one simple command. All student work stays in gitignored `projects/` and `progress.json`, completely isolated from course content.

**Tech Stack:** Bash (setup/update scripts), GitHub (hosting, releases, branch protection), GitHub Pages (optional future landing page)

---

## Context

### The Problem

Students in this course are complete beginners — no Git, no GitHub, no terminal experience beyond what's needed to launch Claude Code. The admin needs to:

1. Distribute course materials to students
2. Push updates (new days, improved instructions) that students can receive
3. Prevent students from accidentally modifying course files (`days/`, `CLAUDE.md`, previews)
4. Keep student work (`projects/`, `progress.json`) completely separate and local

### What Already Exists

- `.gitignore` correctly excludes `projects/*` and `progress.json`
- `projects/.gitkeep` ensures the folder exists in the repo
- `progress.json` template exists with empty state
- 11 day files + 11 preview HTML files in `days/`
- `README.md` with getting started instructions (needs rewrite for beginners)
- `CLAUDE.md` with full course teaching instructions
- Local git repo on `master` branch, **no remote configured**
- **Note:** There may be uncommitted changes to `CLAUDE.md` and `days/day-01.md`. Commit all pending changes before starting Task 1.

### Important: Windows/WSL Limitation

The `chmod` file permission approach works inside the native WSL filesystem (e.g., `~/100-Days-Agentic-Engineering`). However, it does **not** work on Windows-mounted paths (e.g., `/mnt/c/Users/...`). The README must instruct WSL students to clone into their home directory (`~`), not their Windows filesystem.

### Recommended Distribution Strategy

**Primary:** One-line install command (wraps `git clone` + setup — student never sees git)
**Fallback:** ZIP download from GitHub Releases for students who can't run the install command
**Future:** Landing page with visual instructions (Option C — not in this plan)

### Permission Model After Setup

| Path | Owner | Student Permissions |
|------|-------|---------------------|
| `days/*` | Admin (via git) | Read-only |
| `CLAUDE.md` | Admin (via git) | Read-only |
| `README.md` | Admin (via git) | Read-only |
| `setup.sh` | Admin (via git) | Read + Execute |
| `update-course.sh` | Admin (via git) | Read + Execute |
| `projects/*` | Student | Read + Write |
| `progress.json` | Student | Read + Write |

---

## File Structure

Files to create or modify:

```
100-Days-Agentic-Engineering/
├── .gitignore                          # MODIFY: add docs/admin/ to gitignore (admin-only)
├── CLAUDE.md                           # NO CHANGE (already correct)
├── README.md                           # MODIFY: rewrite Getting Started for beginners
├── setup.sh                            # CREATE: setup + install script
├── update-course.sh                    # CREATE: student update command
├── docs/
│   └── admin/
│       └── DISTRIBUTION.md             # CREATE: admin guide for releases & updates
└── tests/
    └── test-setup.sh                   # CREATE: automated verification of setup/update scripts
```

---

## Tasks

### Task 1: Setup Script

The core script that locks down course files and initialises student workspace. Also supports `--install` mode for the one-line download command.

**Files:**
- Create: `setup.sh`

- [ ] **Step 1: Create the setup script with both modes**

```bash
#!/bin/bash
# 100 Days of Agentic Engineering — Setup Script
# Run this once after downloading the course.
# With --install flag: downloads the course first, then sets up.

set -e

REPO_URL="https://github.com/OWNER/100-Days-Agentic-Engineering.git"
COURSE_DIR="100-Days-Agentic-Engineering"

# ─── Install Mode ───────────────────────────────────────────────
# When called with --install, download the course first
if [ "$1" = "--install" ]; then
    echo ""
    echo "=========================================="
    echo "  100 Days of Agentic Engineering"
    echo "  Downloading the course..."
    echo "=========================================="
    echo ""

    # Check if git is available
    if ! command -v git &> /dev/null; then
        echo "ERROR: Git is not installed on your computer."
        echo ""
        echo "Install it first:"
        echo "  Mac:     Run 'xcode-select --install' in Terminal"
        echo "  Windows: Git comes with WSL (Ubuntu)"
        echo "  Linux:   Run 'sudo apt install git'"
        echo ""
        exit 1
    fi

    # Check if course folder already exists
    if [ -d "$COURSE_DIR" ]; then
        echo "The course folder already exists!"
        echo "If you want a fresh download, remove it first:"
        echo "  rm -rf $COURSE_DIR"
        echo ""
        echo "Or to update your existing course:"
        echo "  cd $COURSE_DIR"
        echo "  bash update-course.sh"
        echo ""
        exit 1
    fi

    # Clone the repo
    echo "Downloading course files..."
    git clone "$REPO_URL" "$COURSE_DIR"
    cd "$COURSE_DIR"

    echo "✓ Course downloaded"
    echo ""
    # Fall through to setup steps below
fi

# ─── Setup Mode ─────────────────────────────────────────────────
echo ""
echo "=========================================="
echo "  100 Days of Agentic Engineering"
echo "  Setting up your course..."
echo "=========================================="
echo ""

# Check we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -d "days" ]; then
    echo "ERROR: Please run this from inside the 100-Days-Agentic-Engineering folder."
    echo ""
    echo "Try this:"
    echo "  cd 100-Days-Agentic-Engineering"
    echo "  bash setup.sh"
    echo ""
    exit 1
fi

# Create projects folder if it doesn't exist
mkdir -p projects
if [ ! -f "projects/.gitkeep" ]; then
    touch projects/.gitkeep
fi

# Create a fresh progress.json if it doesn't exist
if [ ! -f "progress.json" ]; then
    echo '{"last_completed": 0, "days_completed": [], "days_started": []}' > progress.json
    echo "  ✓ Created your progress tracker"
else
    echo "  ✓ Progress tracker already exists (keeping your progress)"
fi

# Set course files to read-only (student can't accidentally edit)
chmod -R a-w days/
chmod a-w CLAUDE.md
chmod a-w README.md
echo "  ✓ Course files protected (read-only)"

# Make sure projects folder is writable
chmod -R u+w projects/
chmod u+w progress.json 2>/dev/null || true
echo "  ✓ Your project folder is ready"

# Make scripts executable
chmod u+x setup.sh 2>/dev/null || true
chmod u+x update-course.sh 2>/dev/null || true

echo ""
echo "=========================================="
echo ""
echo "  You're all set!"
echo ""
echo "  To start the course, type:"
echo ""
echo "    claude"
echo ""
echo "  When Claude opens, type:"
echo ""
echo "    day 1"
echo ""
echo "=========================================="
echo ""
```

- [ ] **Step 2: Make setup.sh executable**

Run: `chmod +x setup.sh`

- [ ] **Step 3: Test setup in normal mode**

Run: `bash setup.sh`

Verify with these commands:
```bash
# Course files should be read-only (no 'w' in permissions)
ls -la days/day-01.md
# Expected: -r--r--r--

# projects/ should be writable
ls -la projects/
# Expected: drwxr-xr-x or similar with 'w' for user

# progress.json should exist and be writable
ls -la progress.json
# Expected: -rw-r--r-- or similar with 'w' for user

# Writing to course files should fail
echo "test" >> days/day-01.md 2>&1
# Expected: "Permission denied"
```

- [ ] **Step 4: Restore write permissions for admin (yourself)**

Run: `chmod -R u+w days/ CLAUDE.md README.md`

This is needed so you can continue editing. The read-only protection is for students.

- [ ] **Step 5: Commit**

```bash
git add setup.sh
git commit -m "feat: add setup script with install mode and file protection"
```

---

### Task 2: Update Script

A simple script students run to get new course content. Wraps `git pull` behind friendly output.

**Files:**
- Create: `update-course.sh`

- [ ] **Step 1: Create the update script**

```bash
#!/bin/bash
# 100 Days of Agentic Engineering — Update Script
# Run this to get the latest course materials.
# Your projects and progress are never affected by updates.

set -e

# Always re-lock course files on exit, even if the script fails partway through
relock_files() {
    chmod -R a-w days/ 2>/dev/null || true
    chmod a-w CLAUDE.md 2>/dev/null || true
    chmod a-w README.md 2>/dev/null || true
    chmod a-w setup.sh 2>/dev/null || true
    chmod a-w update-course.sh 2>/dev/null || true
}
trap relock_files EXIT

echo ""
echo "=========================================="
echo "  Checking for course updates..."
echo "=========================================="
echo ""

# Check we're in the right directory
if [ ! -f "CLAUDE.md" ] || [ ! -d "days" ]; then
    echo "ERROR: Please run this from inside the 100-Days-Agentic-Engineering folder."
    echo ""
    echo "Try this:"
    echo "  cd 100-Days-Agentic-Engineering"
    echo "  bash update-course.sh"
    echo ""
    exit 1
fi

# Check if this is a git repo (ZIP downloads won't have .git/)
if [ ! -d ".git" ]; then
    echo "This copy of the course was downloaded as a ZIP file."
    echo "To get updates, please re-download the latest version from:"
    echo ""
    echo "  https://github.com/OWNER/100-Days-Agentic-Engineering/releases/latest"
    echo ""
    echo "Your projects in the 'projects/' folder won't be affected."
    echo "Just copy your 'projects/' folder and 'progress.json' to the new download."
    echo ""
    exit 0
fi

# Temporarily make course files writable so git can update them
chmod -R u+w days/ 2>/dev/null || true
chmod u+w CLAUDE.md 2>/dev/null || true
chmod u+w README.md 2>/dev/null || true
chmod u+w setup.sh 2>/dev/null || true
chmod u+w update-course.sh 2>/dev/null || true

# Reset any accidental local changes to course files
# (shouldn't happen with read-only, but just in case)
git checkout -- days/ CLAUDE.md README.md 2>/dev/null || true

# Pull latest changes
echo "  Downloading updates..."
echo ""
if git pull origin main --ff-only 2>&1; then
    echo ""
    echo "  ✓ Course updated to the latest version!"
else
    echo ""
    echo "  Could not update automatically."
    echo "  This sometimes happens if something unexpected changed."
    echo ""
    echo "  Try running the command again. If it still fails,"
    echo "  you can re-download the course from:"
    echo "    https://github.com/OWNER/100-Days-Agentic-Engineering/releases/latest"
    echo ""
    echo "  Your projects in 'projects/' are safe — they are never touched by updates."
fi

# Re-lock is handled by the EXIT trap above

echo ""
echo "=========================================="
echo ""
echo "  Run 'claude' to continue the course."
echo ""
echo "=========================================="
echo ""
```

- [ ] **Step 2: Make update-course.sh executable**

Run: `chmod +x update-course.sh`

- [ ] **Step 3: Test the update script locally**

Run: `bash update-course.sh`

Expected: Since there's no remote yet, it will fail gracefully. Once a remote is configured, it should pull and re-lock.

- [ ] **Step 4: Commit**

```bash
git add update-course.sh
git commit -m "feat: add update script for students to receive course updates"
```

---

### Task 3: Automated Test Script

A script that verifies the setup and update scripts work correctly. Useful for the admin to run before releasing.

**Files:**
- Create: `tests/test-setup.sh`

- [ ] **Step 1: Create the test script**

```bash
#!/bin/bash
# Tests for setup.sh and update-course.sh
# Run from the repo root: bash tests/test-setup.sh

set -e

# Always restore admin write permissions, even if test is interrupted
trap 'chmod -R u+w days/ CLAUDE.md README.md 2>/dev/null' EXIT

PASS=0
FAIL=0
ERRORS=""

# Helper function
check() {
    local description="$1"
    local command="$2"
    local expected="$3"

    if eval "$command" > /dev/null 2>&1; then
        if [ "$expected" = "should_fail" ]; then
            FAIL=$((FAIL + 1))
            ERRORS="$ERRORS\n  FAIL: $description (expected failure, got success)"
        else
            PASS=$((PASS + 1))
            echo "  ✓ $description"
        fi
    else
        if [ "$expected" = "should_fail" ]; then
            PASS=$((PASS + 1))
            echo "  ✓ $description"
        else
            FAIL=$((FAIL + 1))
            ERRORS="$ERRORS\n  FAIL: $description"
        fi
    fi
}

echo ""
echo "Running setup tests..."
echo ""

# ─── Test setup.sh exists and is executable ─────────────────
check "setup.sh exists" "test -f setup.sh"
check "setup.sh is executable" "test -x setup.sh"

# ─── Test update-course.sh exists and is executable ─────────
check "update-course.sh exists" "test -f update-course.sh"
check "update-course.sh is executable" "test -x update-course.sh"

# ─── Run setup.sh ───────────────────────────────────────────
echo ""
echo "Running setup.sh..."
bash setup.sh

echo ""
echo "Verifying setup results..."
echo ""

# ─── Test course files are read-only ────────────────────────
check "days/ is read-only" "test ! -w days/day-01.md"
check "CLAUDE.md is read-only" "test ! -w CLAUDE.md"
check "README.md is read-only" "test ! -w README.md"

# ─── Test writing to course files fails ─────────────────────
check "Cannot write to days/day-01.md" "echo test >> days/day-01.md" "should_fail"
check "Cannot write to CLAUDE.md" "echo test >> CLAUDE.md" "should_fail"

# ─── Test student files are writable ────────────────────────
check "projects/ directory exists" "test -d projects"
check "progress.json exists" "test -f progress.json"
check "progress.json is writable" "test -w progress.json"

# ─── Test progress.json has valid JSON ──────────────────────
check "progress.json is valid JSON" "python3 -c 'import json; json.load(open(\"progress.json\"))'"

# ─── Test student can create project files ──────────────────
mkdir -p projects/test-project
echo "test" > projects/test-project/test.txt
check "Can create files in projects/" "test -f projects/test-project/test.txt"
rm -rf projects/test-project

# ─── Restore write permissions for admin ────────────────────
chmod -R u+w days/ CLAUDE.md README.md

# ─── Report ─────────────────────────────────────────────────
echo ""
echo "=========================================="
echo "  Results: $PASS passed, $FAIL failed"
echo "=========================================="
if [ $FAIL -gt 0 ]; then
    printf "%b\n" "$ERRORS"
    echo ""
    exit 1
else
    echo "  All tests passed!"
    echo ""
fi
```

- [ ] **Step 2: Make test script executable**

Run: `chmod +x tests/test-setup.sh`

- [ ] **Step 3: Run the tests**

Run: `bash tests/test-setup.sh`

Expected: All tests pass. Output shows checkmarks for each verification.

- [ ] **Step 4: Commit**

```bash
git add tests/test-setup.sh
git commit -m "test: add automated verification for setup and update scripts"
```

---

### Task 4: Rewrite README for Non-Technical Audience

Replace the current Getting Started section with language appropriate for someone who has never used a terminal. Two download paths. Update instructions.

**Files:**
- Modify: `README.md`

- [ ] **Step 1: Read current README**

Run: Read `README.md` to understand current structure.

- [ ] **Step 2: Rewrite the full README**

Replace the entire contents of `README.md` with:

```markdown
# 100 Days of Agentic Engineering

**Learn to build real things with AI — no coding experience needed**

---

This is a hands-on course where you and an AI partner build 100 real projects together, one per day. You describe what you want, and Claude Code helps you build it. No coding experience required — you'll learn by doing, starting from Day 1.

## What You Need

- A computer (Mac, Windows, or Linux)
- An internet connection
- A Claude subscription (Pro, Team, or Enterprise) — [get one here](https://claude.ai/code)

## Getting Started

### Step 1: Install Claude Code

Visit [claude.ai/code](https://claude.ai/code) and follow the instructions for your computer.

- **Mac:** Follow the installer
- **Windows:** You'll need to install WSL first — [follow this guide](https://learn.microsoft.com/en-us/windows/wsl/install), then install Claude Code inside it. **Important:** Download the course inside WSL (your `~` home directory), not in a Windows folder like `/mnt/c/Users/...`
- **Linux:** Follow the installer

### Step 2: Download This Course

**Option A — The Quick Way (recommended)**

Open your Terminal and paste this command:

```
curl -fsSL https://raw.githubusercontent.com/OWNER/100-Days-Agentic-Engineering/main/setup.sh | bash -s -- --install
```

> **How to open Terminal:**
> - **Mac:** Press `Cmd + Space`, type "Terminal", press Enter
> - **Windows:** Open the Start menu, search for "Ubuntu"
> - **Linux:** Open your terminal application

**Option B — Manual Download**

1. [Click here to download the course](https://github.com/OWNER/100-Days-Agentic-Engineering/releases/latest) (look for the "Source code (zip)" link)
2. Unzip the downloaded file
3. Open Terminal and type these commands, pressing Enter after each:

```
cd Downloads
cd 100-Days-Agentic-Engineering-*
bash setup.sh
```

> **Windows/WSL users:** Move the unzipped folder into your WSL home directory first. In your Ubuntu terminal, type `cd ~` and work from there — not from `/mnt/c/Users/...`.

### Step 3: Start Learning

In your Terminal, make sure you're in the course folder, then type:

```
claude
```

When Claude Code opens, type:

```
day 1
```

That's it — Claude will guide you from here!

## Getting Updates

When new days or improvements are released, open Terminal in your course folder and type:

```
bash update-course.sh
```

Your projects and progress are never affected by updates — only the course materials get refreshed.

## Frequently Asked Questions

**Do I need to know how to code?**

No! This course teaches you to build things by describing what you want. Coding knowledge comes naturally through the process.

**What language will I learn?**

The course starts with web pages (HTML, CSS, JavaScript) so you can see results immediately in your browser. You can ask Claude to use a different language any time.

**How long does each day take?**

Most days take 45 to 90 minutes. There's no timer and no deadline — go at your own pace.

**Do I need to do them in order?**

Recommended but not required. Each day builds on skills from previous days, but if a project catches your eye, feel free to jump ahead.

**What if something goes wrong?**

Tell Claude Code what happened — describe what you see. It's designed to help you troubleshoot. If you're truly stuck, you can always start the day over.

**How do I show my projects to friends?**

Your projects are saved in the `projects/` folder on your computer. You can open them in a browser, send the files to a friend, or take a screen recording. We'll cover sharing in more detail during the course.

## Platform Notes

This course works on Mac, Windows (via WSL), and Linux. All instructions inside the course are given to you by Claude Code directly, so you do not need any other materials.

---

Version 1.0, March 2026 — Created by Andrew Larkey
```

- [ ] **Step 3: Verify README renders correctly**

Run: `cat README.md` and visually check formatting.

Alternatively, if you push to GitHub later, check the rendered version there.

- [ ] **Step 4: Commit**

```bash
git add README.md
git commit -m "docs: rewrite README for non-technical beginners with two download paths"
```

---

### Task 5: Update .gitignore for Test Artifacts

Add test artifact directory to `.gitignore` so temporary test output isn't committed.

**Files:**
- Modify: `.gitignore`

- [ ] **Step 1: Add test artifacts to .gitignore**

Add to the end of `.gitignore`:

```
# Test artifacts
tests/tmp/
```

- [ ] **Step 2: Commit**

```bash
git add .gitignore
git commit -m "chore: add test artifacts to gitignore"
```

---

### Task 6: Admin Documentation

A guide for you (the admin) on how to release updates, add new days, and troubleshoot student issues.

**Files:**
- Create: `docs/admin/DISTRIBUTION.md`

- [ ] **Step 1: Create the admin docs directory**

Run: `mkdir -p docs/admin`

- [ ] **Step 2: Write the admin guide**

```markdown
# Course Distribution — Admin Guide

## How Students Get the Course

### Primary: One-Line Install Command

Students paste this into their Terminal:

```
curl -fsSL https://raw.githubusercontent.com/OWNER/100-Days-Agentic-Engineering/main/setup.sh | bash -s -- --install
```

This clones the repo and runs `setup.sh` which:
1. Creates the `projects/` folder
2. Creates `progress.json` with empty state
3. Sets all course files (`days/`, `CLAUDE.md`, `README.md`) to read-only
4. Leaves `projects/` and `progress.json` writable

### Fallback: ZIP Download

Students download from GitHub Releases:
`https://github.com/OWNER/100-Days-Agentic-Engineering/releases/latest`

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
4. Re-locks course files to read-only
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
```

- [ ] **Step 3: Commit**

```bash
git add docs/admin/DISTRIBUTION.md
git commit -m "docs: add admin guide for course distribution and updates"
```

---

### Task 7: Update URLs with Real GitHub Username

Replace all `OWNER` placeholders with your actual GitHub username. **This must happen before pushing to GitHub** so the repo never contains placeholder URLs.

**Files:**
- Modify: `setup.sh` (line with `REPO_URL`)
- Modify: `update-course.sh` (line with fallback URL)
- Modify: `README.md` (install command and download links)
- Modify: `docs/admin/DISTRIBUTION.md` (all GitHub URLs)

- [ ] **Step 1: Determine your GitHub username**

Run: `gh api user --jq '.login'`

Note the output — this is used in all following steps.

- [ ] **Step 2: Replace OWNER in all files**

Run a global find-and-replace across all four files. Replace every instance of `OWNER` with your actual GitHub username:

```bash
# Replace in all files at once (substitute YOUR_USERNAME)
# Uses perl -pi which works identically on macOS and Linux
perl -pi -e 's/OWNER/YOUR_USERNAME/g' setup.sh update-course.sh README.md docs/admin/DISTRIBUTION.md
```

- [ ] **Step 3: Verify replacements**

Run: `grep -r "OWNER" setup.sh update-course.sh README.md docs/admin/DISTRIBUTION.md`

Expected: No matches. If any `OWNER` strings remain, fix them manually.

- [ ] **Step 4: Commit**

```bash
git add setup.sh update-course.sh README.md docs/admin/DISTRIBUTION.md
git commit -m "chore: replace OWNER placeholders with actual GitHub username"
```

---

### Task 8: GitHub Repository Setup

Create the GitHub repo, configure protections, and publish the first release. All placeholder URLs were replaced in Task 7.

**Files:**
- No file changes — all GitHub configuration

**Prerequisites:**
- GitHub CLI (`gh`) installed and authenticated
- All previous tasks committed (Tasks 1-7)
- No `OWNER` placeholders remaining in any files

- [ ] **Step 1: Rename branch from master to main**

```bash
git branch -M main
```

- [ ] **Step 2: Create GitHub repository and push**

```bash
gh repo create 100-Days-Agentic-Engineering --public --source=. --push
```

Expected: Repo created, all code pushed to `main`.

- [ ] **Step 3: Verify repo is accessible**

Run: `gh repo view --web`

Expected: Opens the GitHub repo page in your browser. README should render correctly with real URLs (no `OWNER` placeholders).

- [ ] **Step 4: Configure branch protection**

Go to the GitHub web UI: Settings > Branches > Add branch protection rule:
- Branch name pattern: `main`
- Check "Restrict who can push to matching branches"
- Add only yourself

Note: Fine-grained branch protection rules require GitHub Pro or an org. For a public repo on a free plan, the primary protection is that students clone (not fork) and course files are set read-only by `setup.sh`. Students don't have push access to your repo regardless.

- [ ] **Step 5: Create first GitHub Release**

```bash
gh release create v1.0.0 \
  --title "Phase 1: Days 1-11" \
  --notes "$(cat <<'EOF'
# 100 Days of Agentic Engineering — Phase 1

The first 11 days of the course are ready!

## What's Included
- Days 1-11 with full instructions and animated previews
- Setup script for easy installation
- Update script for receiving future improvements

## Getting Started
See the README for installation instructions.
EOF
)"
```

Expected: Release created with auto-generated ZIP download links.

- [ ] **Step 6: Note the release ZIP URL**

Run: `gh release view v1.0.0`

Copy the "Source code (zip)" URL — this is what students use for the manual download path.

---

### Task 9: End-to-End Student Experience Test (Git Install Path)

Simulate the complete student journey using the one-line install command in an isolated directory.

**Files:**
- No changes — verification only

**Prerequisites:**
- Task 8 complete (repo is on GitHub)

- [ ] **Step 1: Create a temp directory to simulate a student**

```bash
mkdir -p /tmp/test-student
cd /tmp/test-student
```

- [ ] **Step 2: Run the one-line install command**

Use your actual GitHub username (from Task 7 Step 1):

```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/100-Days-Agentic-Engineering/main/setup.sh | bash -s -- --install
```

Expected: Course downloads, setup runs, success message shown.

- [ ] **Step 3: Verify course files are read-only**

```bash
cd 100-Days-Agentic-Engineering
echo "test" >> days/day-01.md
```

Expected: "Permission denied"

- [ ] **Step 4: Verify student can create projects**

```bash
mkdir -p projects/day-01-test
echo "hello" > projects/day-01-test/index.html
cat projects/day-01-test/index.html
```

Expected: "hello" — student workspace is fully writable.

- [ ] **Step 5: Verify progress.json works**

```bash
cat progress.json
```

Expected: `{"last_completed": 0, "days_completed": [], "days_started": []}`

- [ ] **Step 6: Verify update script works**

```bash
bash update-course.sh
```

Expected: "Course updated to the latest version!" or "Already up to date." Course files should still be read-only after update.

- [ ] **Step 7: Clean up test directory**

```bash
rm -rf /tmp/test-student
```

---

### Task 10: End-to-End Student Experience Test (ZIP Download Path)

Simulate the student journey using the manual ZIP download to verify it works and shows the correct message for updates.

**Files:**
- No changes — verification only

- [ ] **Step 1: Download the ZIP release**

```bash
mkdir -p /tmp/test-student-zip
cd /tmp/test-student-zip
gh release download v1.0.0 --repo YOUR_USERNAME/100-Days-Agentic-Engineering --archive zip
```

Expected: ZIP file downloaded.

- [ ] **Step 2: Unzip and run setup**

```bash
unzip *.zip
cd 100-Days-Agentic-Engineering-*
bash setup.sh
```

Expected: Setup runs successfully, course files locked.

- [ ] **Step 3: Verify course files are read-only**

```bash
echo "test" >> days/day-01.md
```

Expected: "Permission denied"

- [ ] **Step 4: Verify update script shows ZIP-specific message**

```bash
bash update-course.sh
```

Expected: "This copy of the course was downloaded as a ZIP file." with instructions to re-download. (The ZIP has no `.git/` directory, so the update script detects this.)

- [ ] **Step 5: Clean up test directory**

```bash
rm -rf /tmp/test-student-zip
```

---

## Summary

### What the student sees:

```
1. Install Claude Code                    (one-time, from claude.ai/code)
2. Paste one command in Terminal           (downloads + sets up the course)
3. Type "claude" then "day 1"             (start building!)
4. Type "bash update-course.sh"           (when notified of new content)
```

### What's protected:

```
days/                → Read-only (course content)
CLAUDE.md            → Read-only (teaching instructions)
README.md            → Read-only (getting started)
```

### What students own:

```
projects/            → Their creations (never touched by updates)
progress.json        → Their progress (never touched by updates)
```

### Admin workflow:

```
1. Edit course files locally
2. git commit + git push
3. (Optional) Create a GitHub Release for ZIP downloaders
4. Tell students: "Run bash update-course.sh"
```

No Git. No GitHub. No jargon. Students download, build, and update — all with simple commands they can copy and paste.
