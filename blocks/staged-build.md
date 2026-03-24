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
