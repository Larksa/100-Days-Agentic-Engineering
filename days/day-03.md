---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 03: Treasure Island Game

## What They're Building
A text-based choose-your-own-adventure game where the player makes choices that lead to treasure or various humorous endings.

## Concepts Introduced
- `if` / `elif` / `else` statements: branching logic
- Nested conditionals: decisions inside decisions
- Comparison operators: `==`, `!=`, `>`, `<`
- `.lower()` for case-insensitive comparison
- Prerequisites: Day 1 (variables, `input()`)

## Design Questions to Ask
1. "How many choice points should your adventure have?"
   - a) One  b) Two or three  c) Ten or more
   (Answer: b -- enough to practice nesting without getting lost)

2. "If the player types 'Left' instead of 'left', should that still work?"
   (Introduce `.lower()` -- the key design insight of the day)

3. "How will you handle unexpected input like 'banana' when you expect 'left' or 'right'?"
   (Introduce `else` as a catch-all)

4. "What makes a text adventure fun -- just choices, or also atmosphere?"
   (Encourage descriptive text and ASCII art)

## Implementation Guide
1. Print a welcome message and set the scene.
2. Present the first choice (e.g., "Go left or right?").
3. Get input and convert to lowercase with `.lower()`.
4. Use `if`/`else` to branch based on the choice.
5. Inside each branch, present another choice (nested conditionals).
6. Each path leads to a win, a loss, or another branch.
7. Add `else` for unexpected input at every decision point.

## Design Tips
- Plan the story tree on paper first. Drawing boxes and arrows prevents getting lost in nested `if` blocks.
- Keep indentation consistent and visible -- this is where indentation-as-syntax really clicks.
- Add atmosphere: a few lines of descriptive text between choices makes the game feel real.
- Use `\n` for spacing between story sections.

## Common Mistakes
- **Not using `.lower()`**: Player types "Left" but code checks for "left". Always convert: `choice = input("...").lower()`.
- **Forgetting `elif`**: Multiple `if` statements instead of `if`/`elif`/`else` causes unexpected behaviour where multiple blocks run.
- **Indentation errors**: With 2-3 levels of nesting, they lose track. Test each branch as you write it.

## Extension Ideas
- Add a scoring system tracking attempts to find the treasure.
- Include an inventory where items affect later choices.

## When They're Stuck
- **"My if statement isn't matching"**: Almost always case sensitivity. Have them `print(choice)` to see what they are comparing, then introduce `.lower()`.
- **"Both if blocks are running"**: Using two separate `if` statements instead of `if`/`elif`. Explain that `if`/`elif` is one decision chain -- only one block runs.
- **"IndentationError"**: Walk through Python's rule: every line inside an `if` must be indented the same amount, nested blocks need another level.
