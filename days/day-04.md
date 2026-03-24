---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 04: Rock Paper Scissors

## What They're Building
A Rock Paper Scissors game where the player competes against the computer, which makes random choices.

## Concepts Introduced
- `import random`: using external modules
- `random.choice()`: picking a random item from a list
- `random.randint()`: generating random integers (alternative approach)
- Lists intro: storing multiple values in `["rock", "paper", "scissors"]`
- Prerequisites: Day 3 (`if`/`elif`/`else`), Day 1 (`input()`)

## Design Questions to Ask
1. "How should the computer make its choice?"
   - a) Always pick rock  b) Follow a pattern  c) Pick randomly
   (Answer: c -- introduce `random.choice()` and why randomness makes the game fair)

2. "How many possible outcomes are there for player vs computer?"
   - a) 3  b) 6  c) 9
   (Answer: c combinations, mapping to 3 results. Walk through the logic.)

3. "Should the player type 'rock' or a number like 1?"
   (Discuss input flexibility and normalisation)

4. "What should happen after one round -- end or continue?"
   (Plant the seed of game loops)

## Implementation Guide
1. Import `random` at the top.
2. Create a list: `choices = ["rock", "paper", "scissors"]`.
3. Get player's choice via `input()`, convert to lowercase.
4. Generate computer's choice with `random.choice(choices)`.
5. Print both choices.
6. Use `if`/`elif`/`else`: check tie first, then three player-win cases, then `else` for computer wins.
7. Display the result clearly.

## Design Tips
- Show both choices before announcing the result -- the reveal builds suspense.
- Keep win logic simple: tie check, then 3 player-win conditions, then `else`. Avoid writing all 9 combinations.
- Add emoji or ASCII art for each gesture to make output engaging.
- Accept flexible input: "rock", "Rock", "ROCK" should all work.

## Common Mistakes
- **Case-sensitive comparison**: Player types "Rock" but code checks "rock". Reinforce `.lower()` from Day 3.
- **Not importing random**: `NameError: name 'random' is not defined`. Explain that `import` must be at the top.
- **Overcomplicated win logic**: Writing 9 separate conditions. Guide toward tie-first, then player-wins, then else.

## Extension Ideas
- Add best-of-3 mode with running score.
- Include "Rock Paper Scissors Lizard Spock" variant.

## When They're Stuck
- **"Computer always picks the same thing"**: They defined the choice outside a loop. Print `random.choice(choices)` several times to prove it varies.
- **"It doesn't handle ties"**: They forgot the `==` check. Walk through logic order: tie first, then wins, then losses.
- **"NameError for random"**: Missing `import random`. Explain modules as libraries of extra tools you bring in.
