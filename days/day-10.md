---
blocks:
  - staged-build
  - bold-iteration
---

# Day 10: Calculator App

## What They're Building
A calculator that performs basic operations and lets the user chain calculations -- using the result of one operation as the starting number for the next.

## Concepts Introduced
- Functions as first-class objects: storing functions in a dictionary so they can be looked up and called dynamically
- Chaining/continuation: using a previous result as the input for the next operation (an introduction to the concept behind recursion)
- `try/except`: handling errors gracefully instead of crashing
- Prerequisites: functions (Day 6), dictionaries (Day 9), while loops (Day 7)

## Design Questions to Ask
1. "If you have four operations (add, subtract, multiply, divide), how could you avoid a long chain of if/elif statements to pick the right one?"
   - a) Use if/elif for each operation
   - b) Store each operation as a function in a dictionary, keyed by the operator symbol
   - c) Use a single function with a flag parameter
   (Answer: b -- this is the key concept of the day. Walk them through how `{"+": add, "-": subtract}` works and why it is powerful)

2. "After the first calculation, should the user start over or continue with the result?"
   - a) Always start fresh with two new numbers
   - b) Offer to continue using the previous result as the first number
   (Answer: b -- this is what makes the calculator feel like a real tool. Discuss how this creates a natural loop)

3. "What should happen if the user tries to divide by zero?"
   (Introduce `try/except` as a way to catch the error and show a friendly message instead of crashing)

4. "How will the user signal they want to start a fresh calculation versus continue chaining?"
   (Discuss giving a clear option after each result: continue with this result, start new, or quit)

## Implementation Guide
1. Define four functions: `add(a, b)`, `subtract(a, b)`, `multiply(a, b)`, `divide(a, b)`. Each returns the result.
2. Create a dictionary mapping operator strings to functions: `{"+": add, "-": subtract, "*": multiply, "/": divide}`.
3. Ask the user for the first number.
4. Start a loop: ask for an operator, then a second number.
5. Look up the operator in the dictionary, call the corresponding function, and display the result.
6. Ask the user: continue with this result, start new, or quit.
7. If continuing, the result becomes the first number for the next operation.
8. Wrap the division (or all operations) in `try/except` to handle errors.

## Design Tips
- This is the day to show the power of dictionaries beyond simple data storage. Functions-in-dicts is a pattern they will use throughout their career.
- Format results nicely -- avoid long floating-point tails. `round(result, 2)` keeps output clean.
- Print the running equation so the user can track their chain: `10 + 5 = 15`, then `15 * 3 = 45`.
- Keep the operation functions simple and pure -- they take two numbers and return a number. No printing inside them.
- Validate that operator input matches one of the dictionary keys before trying to use it.

## Common Mistakes
- **Not handling division by zero**: The program crashes with a `ZeroDivisionError`. Show them `try/except ZeroDivisionError` and print a user-friendly message instead.
- **Storing functions incorrectly in the dictionary**: They write `{"+": add()}` with parentheses, which calls the function immediately instead of storing a reference. Explain the difference between `add` (the function object) and `add()` (calling it right now).
- **Not allowing continuation with the previous result**: After each calculation, they ask for two brand-new numbers. The chaining concept is the core UX of this project -- make sure they implement the "continue" path.

## Extension Ideas
- Add a calculation history that the user can view at any time, showing every operation performed.
- Add power (`**`) and modulo (`%`) operations to the dictionary.
- Implement a memory feature (store/recall) like a real calculator's M+/MR buttons.

## When They're Stuck
- **"It crashes when I divide by zero"**: Walk them through `try/except`. Put the division call inside a `try` block and catch `ZeroDivisionError` with a message like "Cannot divide by zero, try again."
- **"How do I keep calculating with the previous answer?"**: Show them that after getting the result, they can set `first_number = result` and loop back to asking for the operator and second number only. The first number is no longer asked for.
- **"The dictionary lookup gives a KeyError"**: They typed an operator that is not in the dictionary. Add a check: `if operator in operations:` before trying to use it, and show an error message for invalid operators.
