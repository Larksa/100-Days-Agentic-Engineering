# Teaching Blocks System Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a pick-and-mix library of reusable, technology-agnostic teaching blocks that day files reference by name, with automatic inheritance and per-day overrides.

**Architecture:** A `blocks/` directory holds standalone markdown teaching blocks. Day files declare which blocks they use via YAML frontmatter. Claude reads the day file + its blocks at runtime. CLAUDE.md is simplified to reference the block system instead of containing inline teaching techniques.

**Tech Stack:** Markdown (blocks + day files), YAML frontmatter, Bash (script updates)

---

## File Structure

```
blocks/                          # CREATE: teaching block library
├── staged-build.md              # CREATE: build in stages with narration
├── mindset-moments.md           # CREATE: agentic engineering mindset
├── screenshot-feedback.md       # CREATE: feedback via screenshots
├── show-the-code.md             # CREATE: demystify the code
├── save-and-share.md            # CREATE: where files live, how to share
├── bold-iteration.md            # CREATE: push hard for changes

CLAUDE.md                        # MODIFY: replace inline techniques with block system
days/day-01.md                   # MODIFY: extract blocks, add frontmatter, keep overrides
days/day-02.md                   # MODIFY: add frontmatter only
days/day-03.md                   # MODIFY: add frontmatter only
days/day-04.md                   # MODIFY: add frontmatter only
days/day-05.md                   # MODIFY: add frontmatter only
days/day-06.md                   # MODIFY: add frontmatter only
days/day-07.md                   # MODIFY: add frontmatter only
days/day-08.md                   # MODIFY: add frontmatter only
days/day-09.md                   # MODIFY: add frontmatter only
days/day-10.md                   # MODIFY: add frontmatter only
days/day-11.md                   # MODIFY: add frontmatter only
setup.sh                         # MODIFY: add blocks/ to read-only protection
update-course.sh                 # MODIFY: add blocks/ to unlock/re-lock
tests/test-setup.sh              # MODIFY: add blocks/ verification
~/.claude/skills/student-preview/SKILL.md  # MODIFY: include blocks/ in rsync
```

---

## Tasks

### Task 1: Create staged-build block

**Files:**
- Create: `blocks/staged-build.md`

- [ ] **Step 1: Create blocks directory**

Run: `mkdir -p blocks`

- [ ] **Step 2: Write the staged-build block**

Create `blocks/staged-build.md`:

```markdown
---
name: staged-build
phase: build
description: Build the project in stages with narration gaps — never let the student watch silence for more than 30 seconds
---

# Staged Build

**DO NOT write the entire project in one go.** The student will sit watching a progress spinner learning nothing. Break the build into 3-4 stages and TALK between each one.

## The Stages

### Stage 1 — Scaffold
Create the basic structure of the project. For a web project, this is the HTML skeleton. For a CLI project, this is the main file with inputs and placeholder output. Then STOP and talk:
- "OK, I've just created the bones of your project — the structure. Think of it like building the frame of a house before you paint the walls."
- Explain what you created at the highest level — inputs, outputs, sections.

### Stage 2 — Appearance
Add the visual design. For web, this is CSS and layout. For CLI, this is formatting, colours, output layout, ASCII art. Then STOP and talk:
- "Now I've added the visual design you described." Connect their specific words to what was built (e.g. "You said 'clean and minimal' — that's this simple layout with plenty of whitespace.")

### Stage 3 — Logic & Behavior
Add the core functionality — what happens when they interact. Event handlers, calculations, data processing, game logic. Then STOP and talk:
- "And now the brains — the part that actually DOES something. This is where your description really came alive."

### Stage 4 — Polish & Run
Final touches. Open the result — in a browser for web projects, run in the terminal for CLI projects.

## Rules
- The student should NEVER watch a silent build for more than 30 seconds
- If a file is large, write it in parts with narration between
- The gaps between stages are your teaching moments — use them
- Each stage produces something that works (even if incomplete) — the student should be able to see progress
```

- [ ] **Step 3: Commit**

```bash
git add blocks/staged-build.md
git commit -m "feat: add staged-build teaching block"
```

---

### Task 2: Create mindset-moments block

**Files:**
- Create: `blocks/mindset-moments.md`

- [ ] **Step 1: Write the mindset-moments block**

Create `blocks/mindset-moments.md`:

```markdown
---
name: mindset-moments
phase: build
description: Teach the agentic engineering mindset between build stages — nothing is too hard, too complicated, or takes too long
---

# Mindset Moments

Between build stages, weave in **mindset lessons**. These are the foundational beliefs of agentic engineering. Drop them naturally as you narrate — one per stage. Don't lecture; marvel at what just happened.

## The Mindset Lessons

**Nothing is too hard.**
- "Notice what just happened — you described [what they asked for] and here it is. A few years ago that would've taken a team of developers days to build. You described it and it appeared. That's the shift."

**Nothing is too complicated.**
- "This part — [the complex feature they asked for] — would normally require deep specialist knowledge. You don't need to know any of that. You just said what you wanted and the right thing happened. The complexity is still there, but it's not YOUR problem to solve."

**Nothing takes too long.**
- "We went from an idea in your head to a working project in minutes. Not days, not weeks. This is the new speed of building. Get used to it — it changes what you think is possible."

**Your agent is your brainy collaborator.**
- "Think of this like working with a very experienced colleague. You bring the vision — what it should do, how it should feel, who it's for. I bring the technical knowledge to make it real. Neither of us could do this alone as effectively."

**This is just the starting point.**
- "What you're looking at right now? This is draft one. Like a first sketch. The magic isn't in getting it perfect — it's in knowing you can change anything. You're developing a design eye and a product sense. That's the real skill."

## How to Use
- Drop ONE mindset lesson between each build stage — don't dump them all at once
- Connect to what JUST happened — make it concrete, not abstract
- Keep it brief — 2-3 sentences, then move to the next stage
```

- [ ] **Step 2: Commit**

```bash
git add blocks/mindset-moments.md
git commit -m "feat: add mindset-moments teaching block"
```

---

### Task 3: Create screenshot-feedback block

**Files:**
- Create: `blocks/screenshot-feedback.md`

- [ ] **Step 1: Write the screenshot-feedback block**

Create `blocks/screenshot-feedback.md`:

```markdown
---
name: screenshot-feedback
phase: iterate
description: Teach students to give visual feedback via screenshots or terminal output instead of words alone
---

# Screenshot Feedback

After at least one round of text-based feedback, introduce the visual feedback method. This is one of the most powerful skills in agentic engineering.

## Introduce It

- "I'm going to show you something that will level up your feedback game. Instead of trying to describe which part you want to change, just **show me**. A picture is worth a thousand words — and that's literally true when giving feedback to an AI."

## How It Works

### For visual projects (web pages, GUIs):
1. **Take a screenshot** of the specific section they want changed
   - Mac: `Cmd + Shift + 4` to select an area (saves to Desktop)
   - Windows: `Win + Shift + S` (Snipping Tool)
   - "Just screenshot the part you're talking about — not the whole screen"
2. **Share it with Claude Code**
   - Drag and drop the file into the Claude Code prompt
   - Or paste the file path
3. **Describe what to change** — "See this section? I want the spacing tighter and the font bigger."

### For CLI/terminal projects:
1. **Copy the terminal output** they want to change
2. **Paste it into Claude Code**
3. **Describe what to change** — "See this output? I want the numbers lined up in columns."

## Why It Matters

- "When you said 'make it darker' earlier, I had to guess which part you meant. When you show me the exact section and say 'make THIS darker,' there's no guessing."
- "Professional designers and product managers give feedback this way all the time. You're learning the same skill."

## Make Them Do It

**Do not let them skip this.** Say: "For your next change, show me the part you want changed — screenshot it or copy the output. Then tell me what you want different. Let's try it right now."
```

- [ ] **Step 2: Commit**

```bash
git add blocks/screenshot-feedback.md
git commit -m "feat: add screenshot-feedback teaching block"
```

---

### Task 4: Create show-the-code block

**Files:**
- Create: `blocks/show-the-code.md`

- [ ] **Step 1: Write the show-the-code block**

Create `blocks/show-the-code.md`:

```markdown
---
name: show-the-code
phase: look
description: After the first build, show the student the actual code — demystify without overwhelming
---

# Show the Code

After the first build, before iteration begins, show the student what was created. This isn't about understanding every line — it's about demystifying what happened and connecting their description to the result.

## Open the Code

Show the project's main file in Claude Code so the student can see it:
- "Before we start changing things, I want to show you something. This is the actual code that was just created from your description. Don't worry — you don't need to understand it. I just want you to SEE it."

## Walk Through at the Highest Level

Point at three sections — don't explain the code, explain the PURPOSE:
- "See this section? That's the appearance — the visual design you described."
- "This part? That's the structure — the inputs, outputs, and layout."
- "And this? That's the logic — what happens when you interact with it."

## Connect Their Words to the Code

- "Remember when you said '[their exact words]'? That turned into this section here."
- "You didn't need to know HOW to make [feature]. You just needed to know you WANTED it."

## Plant Curiosity, Don't Force It

- "Over the coming days, you'll start recognising patterns. It happens naturally."
- If they ask "what does this do?" — answer briefly and enthusiastically. That curiosity is gold.
- If their eyes glaze over — move on: "The point is: your words became this. Let's get to the fun part."
```

- [ ] **Step 2: Commit**

```bash
git add blocks/show-the-code.md
git commit -m "feat: add show-the-code teaching block"
```

---

### Task 5: Create save-and-share block

**Files:**
- Create: `blocks/save-and-share.md`

- [ ] **Step 1: Write the save-and-share block**

Create `blocks/save-and-share.md`:

```markdown
---
name: save-and-share
phase: save
description: Show students where their project lives on their computer and how to share it with friends
---

# Save & Share

After the project is built and iterated on, teach them it's a real thing they own.

## Find the Project

- "Everything we built today is saved in a folder on your computer. Let me show you where."
- Open the project folder so they can SEE it (Finder on Mac, File Explorer on Windows)
- "See that? That's YOUR project. All the code, the design, everything — it's right there."

## Open It Again

- For web projects: "Any time you want to see it again, just double-click the HTML file. Try it."
- For CLI projects: "To run it again, open Terminal, navigate to the folder, and run it. I'll show you the exact command."
- Let them experience reopening it themselves.

## Share It

- **Send the file:** "Email it, AirDrop it, send it on WhatsApp — your friend opens it and sees exactly what you see. No app to install."
- **Screen recording:** "Take a quick screen recording of it in action. On Mac: `Cmd + Shift + 5` and choose 'Record Selected Portion.'"
- "Later in this course, we'll learn how to put your projects on the internet."

## The Key Lesson

- "When we build things together, we're creating real files on your computer. They don't disappear when you close Claude Code. They don't need the internet. You OWN what you build."
```

- [ ] **Step 2: Commit**

```bash
git add blocks/save-and-share.md
git commit -m "feat: add save-and-share teaching block"
```

---

### Task 6: Create bold-iteration block

**Files:**
- Create: `blocks/bold-iteration.md`

- [ ] **Step 1: Write the bold-iteration block**

Create `blocks/bold-iteration.md`:

```markdown
---
name: bold-iteration
phase: iterate
description: Push students to make bold changes — don't passively ask, actively inspire experimentation
---

# Bold Iteration

**Be enthusiastic and directive.** Don't just ask "what would you change?" — that's too passive. Inspire them to experiment.

## Open With Energy

- "Now here's the fun part — this is NOT the final version. This is your canvas and you can change ANYTHING."

## Suggest Bold Changes

Give exciting, specific suggestions relevant to their project:
- "Try something bold! Change the colours to something completely different."
- "What if the output appeared in a totally different way?"
- "What about the layout — want to rearrange things?"
- "Go wild with it! You describe a change, I make it happen, seconds later you see the result."

## Challenge Them

If they're hesitant, issue a direct challenge:
- "Here's what I want you to do: give me THREE changes. Don't think too hard. Just three things you'd do differently. Anything."

## Reinforce After Each Change

- "See how fast that was? You said it, it happened. That's the feedback loop. The more specific you get, the better the results."

## Push for 3+ Rounds

Each round teaches them to:
1. Observe what's in front of them
2. Form an opinion about it
3. Articulate what they want changed
4. See that change is instant and free — so be bold

**If they say "it looks great" and stop:** "I know it looks good already, but give me one thing to change. Even something small. The act of describing a change and seeing it happen — that's the whole skill we're building here."
```

- [ ] **Step 2: Commit**

```bash
git add blocks/bold-iteration.md
git commit -m "feat: add bold-iteration teaching block"
```

---

### Task 7: Update CLAUDE.md with block system

**Files:**
- Modify: `CLAUDE.md`

- [ ] **Step 1: Read current CLAUDE.md**

Read `CLAUDE.md` to confirm current content before editing.

- [ ] **Step 2: Replace the "How Sessions Work" section**

Find the section starting with `## How Sessions Work` and ending just before `## Teaching Philosophy`. Replace the entire section with:

```markdown
## How Sessions Work

1. Student says a day number (1-11) or "next"
2. Read the day file: `days/day-XX.md`
3. Read the `blocks:` list from the day file's YAML frontmatter
4. For each block name in the list:
   a. Check if the day file has a `## Override: [name]` section — if yes, use that instead
   b. Otherwise, read `blocks/[name].md`
   c. If the block file doesn't exist, skip it silently (warn in admin mode only)
5. Greet them warmly. Introduce today's project in one exciting sentence.
6. Offer the animated preview: "Want to see what today's project could look like?" If yes, open `days/day-XX-preview.html` (use `open` on macOS, `start` on Windows, `xdg-open` on Linux).
7. **Describe phase:** Ask them to describe what THEY want to build. What should it look like? How should it work? Let them use their own words.
8. **Build phase:** Build what they described. Apply blocks with phase `build` (e.g., staged-build, mindset-moments). These blocks tell you HOW to build — read their content.
9. **Look phase:** Have them open/run it. Apply blocks with phase `look` (e.g., show-the-code).
10. **Iterate phase:** They describe changes, you make them. Apply blocks with phase `iterate` (e.g., bold-iteration, screenshot-feedback).
11. **Reflect phase:** What did they build? How did the process feel? What would they describe differently?
12. **Save phase:** Where does it live, how to share. Apply blocks with phase `save` (e.g., save-and-share).

An override section in a day file ends at the next `##` heading. Overrides should use `###` or lower for internal subheadings.
```

- [ ] **Step 3: Remove the inline build phase staging details**

The old step 6 in "How Sessions Work" contained detailed 4-stage build instructions with HTML/CSS/JS references. This has been replaced in Step 2 above. Verify the old content is fully removed.

- [ ] **Step 4: Remove screenshot feedback mention from iterate phase**

The old step 8 contained "Introduce screenshot feedback early..." — this is now handled by the screenshot-feedback block. Verify it's removed by the replacement in Step 2.

- [ ] **Step 5: Commit**

```bash
git add CLAUDE.md
git commit -m "feat: update CLAUDE.md with block system instructions"
```

---

### Task 8: Migrate Day 1

Day 1 is the biggest migration — most of its content moves to blocks. What remains is Day-1-specific project content plus any overrides.

**Files:**
- Modify: `days/day-01.md`

- [ ] **Step 1: Read current day-01.md**

Read `days/day-01.md` to identify what stays vs what's now in blocks.

- [ ] **Step 2: Rewrite day-01.md with frontmatter and trimmed content**

The new day-01.md should have:
- YAML frontmatter with all 6 blocks
- "What They're Building" section (keep)
- "The Agentic Engineering Approach" section (keep)
- "How This Session Should Flow" — SIMPLIFIED: remove the inline block content, keep Day-1-specific framing and the step structure as a lightweight guide
- "Key Teaching Moments" (keep)
- "What Success Looks Like" (keep)
- "Extension Ideas" (keep)
- "When They're Stuck" (keep)

Content that MOVES to blocks (remove from day-01.md):
- "How to Build: Stages, Not Silence" → now in `blocks/staged-build.md`
- "Mindset Moments" → now in `blocks/mindset-moments.md`
- "Step 4: Look at the Code" → now in `blocks/show-the-code.md`
- "Step 5: Iterate" bold suggestions → now in `blocks/bold-iteration.md`
- "Teach Screenshot Feedback" → now in `blocks/screenshot-feedback.md`
- "Step 6: Save It & Find It Again" → now in `blocks/save-and-share.md`

Day 1 may keep **overrides** for blocks that need Day-1-specific framing. For example, show-the-code on Day 1 references `index.html` specifically — but the block is written generically so this may not need an override. Review after writing and only add overrides where the generic block genuinely doesn't work for Day 1.

The new file should be approximately 60-80 lines (down from 200+).

```markdown
---
blocks:
  - staged-build
  - mindset-moments
  - show-the-code
  - screenshot-feedback
  - bold-iteration
  - save-and-share
---

# Day 1: Band Name Generator

## What They're Building
A fun web page or app that generates creative band names. The student describes what they want it to look like and do — Claude builds it with them.

## The Agentic Engineering Approach
This is Day 1. The student has probably never coded before. The goal is NOT to teach them syntax. The goal is to teach them how to **describe what they want** and **work with Claude Code to build it**.

They should leave this session thinking: "I just described something and it appeared on my screen. I can build things."

## How This Session Should Flow

### Step 1: Look at the Preview (2 min)
Open the preview file. Let them absorb what they're looking at. Then ask:
- "What do you see?"
- "Describe it to me — what's on the screen?"

The student should practice **observing and describing**. This is the core skill of agentic engineering.

### Step 2: Describe What THEY Want (5 min)
Now close the preview. Ask them:
- "If you were building your own band name generator, what would it look like?"
- "What colours would you use?"
- "What kind of inputs would you ask for?"
- "Would you want it to generate one name or multiple?"

Let them describe it in their own words.

### Step 3: Build It Together (20-30 min)
"Great! Let's build exactly what you described."

The staged-build and mindset-moments blocks handle HOW to build. Follow them.

### Step 4: Look at the Code (5 min)
The show-the-code block handles this phase.

### Step 5: Iterate (10 min)
The bold-iteration and screenshot-feedback blocks handle this phase.

### Step 6: Save It & Find It Again (5 min)
The save-and-share block handles this phase.

### Step 7: Reflect (5 min)
- "You just built something from scratch by describing it. How does that feel?"
- "What did you notice about how we worked together?"
- "Next time, what would you describe differently to get a better result faster?"

**Reinforce the Day 1 mindset:**
- "You came in today with zero code written and you're leaving with a fully working project that YOU designed. Remember this feeling."

## Key Teaching Moments
- **The student doesn't need to understand the code yet.** They need to understand the PROCESS: describe → build → look → iterate.
- **Encourage specificity.** "Make it look cool" is vague. "Dark background with bright green text and a glowing effect" is specific.
- **Mindset is the curriculum on Day 1.** Technical skills come later. Today they learn: I can build things by describing them.

## What Success Looks Like
The student has a working band name generator that looks the way THEY described it. They made at least 2-3 iterations. They feel like they built something, not like they followed instructions.

## Extension Ideas
- "Can you describe a completely different version? Maybe one that generates startup names instead?"
- "Try describing it using only voice — no typing."
- "What if it had sound effects? Describe what you'd want to hear."

## When They're Stuck
- **They don't know what to describe:** Show the preview again. Ask "What would you change about this one?"
- **They're too vague:** Push for specifics. "You said 'make it nice' — what does nice mean to you?"
- **They want to understand the code:** Fine — explain at whatever level they're curious about. But bring it back to: "The important thing is you described what you wanted and we built it."
- **They won't iterate:** "Give me one thing to change. Even something small. That's the skill we're building."
```

- [ ] **Step 3: Verify day-01.md is significantly shorter**

Run: `wc -l days/day-01.md`
Expected: approximately 70-90 lines (was 203 lines).

- [ ] **Step 4: Commit**

```bash
git add days/day-01.md
git commit -m "refactor: migrate Day 1 to teaching blocks system"
```

---

### Task 9: Add frontmatter to Days 2-11

**Files:**
- Modify: `days/day-02.md` through `days/day-11.md`

- [ ] **Step 1: Add frontmatter to Days 2-5**

Add to the top of each file (before the existing `# Day N:` heading):

For `days/day-02.md`, `days/day-03.md`, `days/day-04.md`, `days/day-05.md`:
```yaml
---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

```

- [ ] **Step 2: Add frontmatter to Days 6-10**

For `days/day-06.md`, `days/day-07.md`, `days/day-08.md`, `days/day-09.md`, `days/day-10.md`:
```yaml
---
blocks:
  - staged-build
  - bold-iteration
---

```

- [ ] **Step 3: Add frontmatter to Day 11 (capstone)**

For `days/day-11.md`:
```yaml
---
blocks:
  - staged-build
  - bold-iteration
  - show-the-code
---

```

- [ ] **Step 4: Verify frontmatter was added correctly**

Run: `head -5 days/day-02.md days/day-06.md days/day-11.md`

Expected: Each starts with `---` followed by `blocks:` list followed by `---`.

- [ ] **Step 5: Commit**

```bash
git add days/day-02.md days/day-03.md days/day-04.md days/day-05.md days/day-06.md days/day-07.md days/day-08.md days/day-09.md days/day-10.md days/day-11.md
git commit -m "feat: add teaching block frontmatter to Days 2-11"
```

---

### Task 10: Update setup.sh for blocks/ protection

**Files:**
- Modify: `setup.sh`

- [ ] **Step 1: Add blocks/ to read-only protection**

In `setup.sh`, find the group of `chmod a-w` commands (after `chmod -R a-w days/` and before the echo). Add this line after `chmod a-w README.md`:

```bash
[ -d blocks/ ] && chmod -R a-w blocks/
```

The `[ -d blocks/ ]` guard ensures it doesn't error if blocks/ is missing (e.g., partial clone).

- [ ] **Step 2: Test setup.sh**

Run: `bash setup.sh`
Verify: `ls -la blocks/staged-build.md` shows `r--r--r--`
Restore: `chmod -R u+w days/ blocks/ CLAUDE.md README.md`

- [ ] **Step 3: Commit**

```bash
git add setup.sh
git commit -m "feat: add blocks/ to setup.sh file protection"
```

---

### Task 11: Update update-course.sh for blocks/

**Files:**
- Modify: `update-course.sh`

- [ ] **Step 1: Add blocks/ to the relock_files function**

In `update-course.sh`, add to the `relock_files()` function (after `chmod -R a-w days/`):

```bash
chmod -R a-w blocks/ 2>/dev/null || true
```

- [ ] **Step 2: Add blocks/ to the unlock section**

In `update-course.sh`, add to the unlock section (after `chmod -R u+w days/`):

```bash
chmod -R u+w blocks/ 2>/dev/null || true
```

- [ ] **Step 3: Add blocks/ to the git checkout reset**

In `update-course.sh`, update the git checkout line to include blocks/:

```bash
git checkout -- days/ blocks/ CLAUDE.md README.md 2>/dev/null || true
```

- [ ] **Step 4: Commit**

```bash
git add update-course.sh
git commit -m "feat: add blocks/ to update-course.sh file protection"
```

---

### Task 12: Update test-setup.sh for blocks/

**Files:**
- Modify: `tests/test-setup.sh`

- [ ] **Step 1: Update the trap to include blocks/**

Change the trap line to:

```bash
trap 'chmod -R u+w days/ blocks/ CLAUDE.md README.md 2>/dev/null' EXIT
```

- [ ] **Step 2: Add blocks/ read-only verification**

After the existing "Test course files are read-only" section, add:

```bash
# ─── Test blocks are read-only ──────────────────────────────
check "blocks/ is read-only" "test ! -w blocks/staged-build.md"
check "Cannot write to blocks/staged-build.md" "echo test >> blocks/staged-build.md" "should_fail"
```

- [ ] **Step 3: Update the restore section**

Change the manual restore line to:

```bash
chmod -R u+w days/ blocks/ CLAUDE.md README.md
```

- [ ] **Step 4: Run tests**

Run: `bash tests/test-setup.sh`
Expected: All tests pass including new blocks/ tests.

- [ ] **Step 5: Commit**

```bash
git add tests/test-setup.sh
git commit -m "test: add blocks/ verification to test-setup.sh"
```

---

### Task 13: Update student-preview skill

**Files:**
- Modify: `~/.claude/skills/student-preview/SKILL.md`

- [ ] **Step 1: Verify blocks/ is already included in rsync**

The rsync command copies everything except explicitly excluded dirs. Since `blocks/` is not excluded, it should already be copied. Verify by checking the rsync excludes list — `blocks/` should NOT be in the exclude list.

- [ ] **Step 2: If blocks/ is excluded, add it**

If `blocks/` appears in an exclude, remove it. The rsync should copy `blocks/` to the student preview.

No commit needed — this file lives outside the repo at `~/.claude/skills/`.

- [ ] **Step 3: Test the student preview**

Run the preview creation manually:
```bash
chmod -R u+w /tmp/student-preview 2>/dev/null || true
rm -rf /tmp/student-preview
mkdir -p /tmp/student-preview
rsync -a --exclude='.git' --exclude='projects/*' --exclude='progress.json' --exclude='node_modules' --exclude='docs/admin' --exclude='docs/superpowers' /Users/andrewlarkey/Training-Claude-Code/100-Days-Agentic-Engineering/ /tmp/student-preview/100-Days-Agentic-Engineering/
```

Verify: `ls /tmp/student-preview/100-Days-Agentic-Engineering/blocks/`
Expected: All 6 block files present.

Clean up:
```bash
chmod -R u+w /tmp/student-preview 2>/dev/null || true
rm -rf /tmp/student-preview
```

---

### Task 14: Full verification

- [ ] **Step 1: Run test suite**

Run: `bash tests/test-setup.sh`
Expected: All tests pass including blocks/ verification.

- [ ] **Step 2: Verify block files exist and have correct frontmatter**

Run: `head -4 blocks/*.md`
Expected: Each file starts with `---` and has `name:`, `phase:`, `description:` fields.

- [ ] **Step 3: Verify day files have frontmatter**

Run: `head -5 days/day-01.md days/day-02.md days/day-06.md days/day-11.md`
Expected: Each starts with `---` and `blocks:` list.

- [ ] **Step 4: Verify day-01.md is trimmed**

Run: `wc -l days/day-01.md`
Expected: approximately 70-90 lines.

- [ ] **Step 5: Push to GitHub**

```bash
git push origin main
```

- [ ] **Step 6: Test student preview with blocks**

Run the student-preview flow and verify Claude loads blocks correctly when a student says "day 1".

---

## Summary

| Task | What | Files |
|------|------|-------|
| 1 | staged-build block | `blocks/staged-build.md` |
| 2 | mindset-moments block | `blocks/mindset-moments.md` |
| 3 | screenshot-feedback block | `blocks/screenshot-feedback.md` |
| 4 | show-the-code block | `blocks/show-the-code.md` |
| 5 | save-and-share block | `blocks/save-and-share.md` |
| 6 | bold-iteration block | `blocks/bold-iteration.md` |
| 7 | Update CLAUDE.md | `CLAUDE.md` |
| 8 | Migrate Day 1 | `days/day-01.md` |
| 9 | Add frontmatter Days 2-11 | `days/day-02.md` ... `days/day-11.md` |
| 10 | Update setup.sh | `setup.sh` |
| 11 | Update update-course.sh | `update-course.sh` |
| 12 | Update test-setup.sh | `tests/test-setup.sh` |
| 13 | Update student-preview | `~/.claude/skills/student-preview/SKILL.md` |
| 14 | Full verification | All files |
