---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 05: Password Generator

## What They're Building
A program that generates secure random passwords based on user preferences for length and character types.

## Concepts Introduced
- Lists in depth: creating, appending, iterating
- `for` loops: repeating actions a set number of times
- `random.shuffle()`: randomising list order in place
- `string` module: `string.ascii_letters`, `string.digits`, `string.punctuation`
- `"".join()`: converting a list to a string
- Prerequisites: Day 4 (`random`, lists intro), Day 1 (variables)

## Design Questions to Ask
1. "What makes a password strong?"
   - a) Length  b) Character variety  c) Both
   (Answer: c -- strength depends on both entropy and diversity)

2. "How should the user control what goes in their password?"
   - a) Specify count of letters, numbers, symbols separately  b) Just total length
   (Answer: a gives more control and more practice with variables)

3. "If you add 4 letters, then 3 numbers, then 2 symbols in order, what is wrong?"
   (The order is predictable -- this motivates `random.shuffle()`)

4. "How do you turn `['a', '3', '!']` into `'a3!'`?"
   (Introduce `"".join(list)` -- a key Python idiom)

## Implementation Guide
1. Import `random` and `string`.
2. Define character pools using `string.ascii_letters`, `string.digits`, `string.punctuation`.
3. Ask user how many of each character type they want, convert to `int`.
4. Use `for` loops to pick random characters from each pool, appending to a list.
5. Shuffle with `random.shuffle()`.
6. Convert to string with `"".join()`.
7. Display the password.

## Design Tips
- Build as a list, shuffle, then join. This three-step pattern is clean and clear.
- Note that `random.shuffle()` mutates in place and returns `None`. This is a common bug source.
- Use `string` module constants rather than manually typing `"abcdefghij..."` -- teach the habit of using libraries.

## Common Mistakes
- **Not shuffling**: Password ends up as all letters, then numbers, then symbols. Predictable order despite random characters.
- **Trying `str(list)` instead of `"".join(list)`**: Produces `"['a', '3']"` with brackets. Show the correct idiom.
- **`append` vs `+` confusion**: `list.append("abc")` adds one item. For this project, `append` with single `random.choice()` characters is cleanest.

## Extension Ideas
- Add a password strength indicator (weak/medium/strong).
- Exclude ambiguous characters (`0`/`O`, `1`/`l`).

## When They're Stuck
- **"Password always has letters first then numbers"**: Forgot `random.shuffle()`. Building in order is fine, but must shuffle before joining.
- **"How to turn list into string?"**: Show `"".join(list)` -- the `""` is the separator, `.join()` glues elements together.
- **"random.shuffle() returns None"**: They wrote `password = random.shuffle(list)`. Explain shuffle modifies in place. Shuffle first, then join the original list.
