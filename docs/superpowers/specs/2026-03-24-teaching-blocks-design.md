# Teaching Blocks System — Design Spec

## Goal

Create a pick-and-mix library of reusable teaching blocks that day files reference by name. Improving a block once improves it everywhere. Individual days can override a block when needed.

## Problem

Teaching improvements (staged building, mindset moments, screenshot feedback, etc.) are currently either hardcoded in CLAUDE.md or embedded inline in day-01.md. This means:
- Improvements to one day don't propagate to others
- CLAUDE.md grows unwieldy as more teaching techniques are added
- No way to selectively apply teaching techniques per day
- Day 1 is 200+ lines while Days 2-11 are 50-70 lines with no shared structure

## Architecture

### Block Library

A `blocks/` directory at the project root. Each block is a standalone markdown file:

```
blocks/
├── staged-build.md
├── mindset-moments.md
├── screenshot-feedback.md
├── show-the-code.md
├── save-and-share.md
├── bold-iteration.md
```

### Block File Format

```markdown
---
name: screenshot-feedback
phase: iterate
description: Teaches students to give feedback via screenshots instead of words alone
---

[Full teaching instructions for this block]
```

Fields:
- `name` — identifier, matches filename without extension
- `phase` — which part of the session flow this block is MOST relevant to. Valid values: `describe`, `build`, `look`, `iterate`, `reflect`, `save`. This is a **hint for ordering**, not a rigid insertion point. Claude uses judgment about exact placement within the session. A block with `phase: build` might fire between build stages, after the build, or at the start — Claude reads the block content to know precisely when.
- `description` — one-line summary so the admin can scan the library

### Block Content: Technology-Agnostic

Blocks MUST be written to work for both web projects (HTML/CSS/JS) and Python CLI projects. Use general terms:

- "Structure/scaffold" not "HTML skeleton"
- "Appearance/styling" not "CSS"
- "Logic/behavior" not "JavaScript"
- "Open the result" not "open in browser"

Where a block needs to give platform-specific examples, use conditional phrasing:
- "For web projects, open the file in your browser. For Python projects, run it in the terminal."

### Day File Format

Day files gain a `blocks:` frontmatter field listing which blocks they use:

```markdown
---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 02: Tip Calculator

## What They're Building
...
```

The existing `# Day N: Title` heading stays. The frontmatter is added above it.

Day files contain ONLY project-specific content: what they're building, concepts introduced, design questions, implementation guide, tips, common mistakes, extension ideas, and stuck scenarios.

### Concrete Migration Example: Day 02

**Before:**
```markdown
# Day 02: Tip Calculator

## What They're Building
A program that calculates how much each person should pay...
```

**After:**
```markdown
---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 02: Tip Calculator

## What They're Building
A program that calculates how much each person should pay...

[rest of file unchanged]
```

That's it for Days 2-11 — they just get the frontmatter added. Their existing content stays.

### Override Mechanism

When a day needs a custom version of a block, it includes:

```markdown
## Override: mindset-moments

Custom content for this day only...
```

Rules:
- Claude checks the day file for `## Override: [block-name]` before reading the library version
- If found, use the override instead of the library version
- An override replaces the entire block — no merging or partial overrides
- An override section **ends at the next `##` heading** (whether that's another override, or a regular section like `## When They're Stuck`). Overrides should not contain `##`-level subheadings; use `###` or lower within an override.

### Error Handling

If a day file references a block name that doesn't exist in `blocks/` (typo, deleted, etc.):
- Claude skips the missing block and proceeds with the session
- Claude does NOT mention the missing block to the student
- If in admin mode, Claude warns the admin about the missing block

### CLAUDE.md Changes

CLAUDE.md is simplified. The following content MOVES OUT of CLAUDE.md into blocks:

| Current CLAUDE.md Content | Moves To |
|---------------------------|----------|
| Build phase: 4-stage instructions (structure → styling → logic → polish), 30-second rule, narration gaps | `blocks/staged-build.md` |
| "Introduce screenshot feedback early" instruction in iterate phase | `blocks/screenshot-feedback.md` |

The following content STAYS in CLAUDE.md:
- Admin mode section
- Role and philosophy (Your Role section)
- Teaching Philosophy section
- Language and Technology section
- Project Organization section
- Session Start section
- Progress Tracking section
- Available Days section
- Assessment section
- When Things Go Wrong section

The "How Sessions Work" section is updated to:

```
1. Student says a day number (1-11) or "next"
2. Read the day file: `days/day-XX.md`
3. Read the `blocks:` list from the day file's frontmatter
4. For each block name:
   a. Check if the day file has a `## Override: [name]` section — if yes, use that
   b. Otherwise, read `blocks/[name].md`
   c. If the block file doesn't exist, skip it silently (warn in admin mode)
5. Greet them warmly. Introduce today's project in one exciting sentence.
6. Offer the animated preview if one exists.
7. **Describe phase:** Ask them to describe what THEY want to build.
8. **Build phase:** Build what they described. Apply blocks with phase `build` (e.g., staged-build, mindset-moments).
9. **Look phase:** Have them open/run it. Apply blocks with phase `look` (e.g., show-the-code).
10. **Iterate phase:** They describe changes. Apply blocks with phase `iterate` (e.g., bold-iteration, screenshot-feedback).
11. **Reflect phase:** What did they build? Apply blocks with phase `reflect`.
12. **Save phase:** Where does it live, how to share. Apply blocks with phase `save` (e.g., save-and-share).
```

### Runtime Flow

When a student says "day 1":

1. Claude reads `CLAUDE.md` — gets universal instructions + block system rules
2. Claude reads `days/day-01.md` — gets project content + `blocks: [staged-build, mindset-moments, ...]`
3. For each block: check for override in day file, then fall back to library file
4. Claude now has: universal instructions + project content + teaching blocks
5. Claude runs the session, applying each block at its designated phase using judgment

### Default Block Assignments

Starting point (admin adjusts per day as needed):

| Days | Blocks |
|------|--------|
| Day 1 | staged-build, mindset-moments, show-the-code, screenshot-feedback, bold-iteration, save-and-share |
| Days 2-5 | staged-build, mindset-moments, bold-iteration |
| Days 6-10 | staged-build, bold-iteration |
| Day 11 (capstone) | staged-build, bold-iteration, show-the-code |

### File Protection

`setup.sh` and `update-course.sh` updated to include `blocks/` in the read-only protection alongside `days/`:

- `setup.sh`: add `chmod -R a-w blocks/` after the existing `days/` lock
- `update-course.sh`: add `blocks/` to the unlock (before pull) and re-lock (EXIT trap)
- `tests/test-setup.sh`: add verification that `blocks/` is read-only after setup

## Initial Blocks to Create

### 1. staged-build.md (phase: build)
Build the project in 3-4 stages with narration gaps between each. Never let the student watch a silent build for more than 30 seconds. Stages for any project type:
- Stage 1: Scaffold — create the basic structure
- Stage 2: Appearance — add styling/formatting/output design
- Stage 3: Logic — add the behavior and interactivity
- Stage 4: Polish — final touches, open/run the result

### 2. mindset-moments.md (phase: build)
Teach between build stages. Nothing is too hard, nothing is too complicated, nothing takes too long, your agent is your brainy collaborator, this is just the starting point. Connect the student's description to what appeared.

### 3. screenshot-feedback.md (phase: iterate)
Teach students to take a screenshot of the specific part they want changed and share it with Claude Code (drag and drop on Mac, or paste file path). Pair the screenshot with a description of what to change. For CLI projects, teach them to copy-paste the terminal output instead.

### 4. show-the-code.md (phase: look)
After the first build, show the student the code. Walk through at highest level — point, don't explain. Connect their words to what was built. Plant curiosity without forcing it. If they ask questions, answer. If they glaze over, move on.

### 5. save-and-share.md (phase: save)
Show them where the project lives on their computer. Teach them to open it again (double-click for web, run command for Python). Show how to share (send the file, screen recording). Reinforce: you OWN what you build, it's real files on your computer.

### 6. bold-iteration.md (phase: iterate)
Push hard for changes. Don't passively ask "what would you change?" — suggest bold changes, challenge them to give 3 changes, reinforce the feedback loop after each round. Push for at least 3 rounds of iteration.

## Migration Plan

1. Create `blocks/` directory with all 6 block files (technology-agnostic content)
2. Update CLAUDE.md:
   - Remove build phase staging instructions (moves to staged-build block)
   - Remove screenshot feedback mention from iterate phase (moves to screenshot-feedback block)
   - Rewrite "How Sessions Work" to include block loading steps 3-4 and the full phase list (describe, build, look, iterate, reflect, save)
3. Update day-01.md:
   - Add `blocks:` frontmatter
   - Remove inline block content (staged build stages, mindset moments, screenshot feedback, show the code, save and share, bold iteration)
   - Keep Day-1-specific content and any overrides needed
4. Update days 2-11:
   - Add `blocks:` frontmatter to each
   - Keep all existing content unchanged
5. Update setup.sh: add `blocks/` to `chmod -R a-w`
6. Update update-course.sh: add `blocks/` to unlock/re-lock in EXIT trap
7. Update tests/test-setup.sh: add `blocks/` read-only verification
8. Update student-preview skill: add `blocks/` to rsync include
9. Test with student-preview skill to verify blocks load correctly
