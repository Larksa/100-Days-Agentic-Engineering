---
blocks:
  - staged-build
  - mindset-moments
  - bold-iteration
---

# Day 02: Tip Calculator

## What They're Building
A program that calculates how much each person should pay when splitting a restaurant bill, including a chosen tip percentage.

## Concepts Introduced
- Math operators: `+`, `-`, `*`, `/`
- Type conversion: `int()`, `float()` to convert string input to numbers
- f-strings: formatted string literals like `f"Total: {amount}"`
- Rounding: `round()` and `f"{amount:.2f}"`
- Prerequisites: Day 1 (variables, `input()`, `print()`)

## Design Questions to Ask
1. "What three pieces of information does your calculator need?"
   - a) Bill total, tip %, number of people  b) Bill and tip only  c) Just the bill
   (Answer: a -- walk through why each input matters)

2. "When the user types '120' as the bill amount, what data type is that?"
   - a) Integer  b) Float  c) String
   (Answer: c -- `input()` always returns a string. This is the core lesson.)

3. "How many decimal places should the final amount show?"
   (Guide toward 2 -- money convention)

4. "What happens if someone enters 0 for the number of people?"
   (Division by zero -- they should recognise the danger even if they do not solve it yet)

## Implementation Guide
1. Ask for the total bill and convert to `float`.
2. Ask for the tip percentage and convert to `int`.
3. Ask how many people are splitting and convert to `int`.
4. Calculate: tip amount, total with tip, per-person amount.
5. Round to 2 decimal places.
6. Display using an f-string: `f"Each person should pay: ${amount:.2f}"`.

## Design Tips
- Show the full calculation breakdown, not just the final number. Users trust calculators more when they see the working.
- Use `f"{amount:.2f}"` to always show exactly 2 decimal places (`round()` alone shows `10.0` not `10.00`).
- Prompt clearly: `"What is the total bill? $"` is better than `"Enter bill:"`.

## Common Mistakes
- **Forgetting to convert input**: They get `TypeError` when multiplying a string by a number. This is the key lesson -- emphasise it.
- **Using `int()` for the bill instead of `float()`**: Works for `$85` but crashes on `$85.50`.
- **Not rounding**: Results like `$27.333333333`. Show both `round(amount, 2)` and the f-string approach.

## Extension Ideas
- Add input validation: reject negative numbers or non-numeric input.
- Show a receipt-style breakdown: subtotal, tip, total, per-person.

## When They're Stuck
- **"TypeError: can't multiply sequence by non-int"**: They forgot to convert input. `"120" * 0.15` fails -- need `float(input(...))`.
- **"Too many decimal places"**: Show `round(value, 2)` then `f"{value:.2f}"` as the display solution.
- **"My answer is wrong"**: Have them print each intermediate variable. Often tip is applied as 15 instead of 0.15.
