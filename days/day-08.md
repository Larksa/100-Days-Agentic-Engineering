# Day 08: Caesar Cipher

## What They're Building
An encoder/decoder that shifts letters in a message by a chosen number of positions in the alphabet -- the classic Caesar Cipher.

## Concepts Introduced
- Function parameters and return values: writing functions that take input and give output rather than just printing
- `ord()` and `chr()`: converting between characters and their numeric codes
- Modular arithmetic (`%`): wrapping around the end of the alphabet
- String iteration: processing a message character by character
- Prerequisites: functions (Day 6), for loops (Day 5)

## Design Questions to Ask
1. "Should encoding and decoding be two separate functions or one function that handles both?"
   - a) Two separate functions, one for each direction
   - b) One function where the direction controls whether to add or subtract the shift
   (Answer: b -- guide them to see that decoding is just encoding with a negative shift, so one function handles both)

2. "What should happen to characters that are not letters, like spaces, numbers, or punctuation?"
   - a) Remove them
   - b) Shift them too
   - c) Leave them exactly as they are
   (Answer: c -- preserving non-alpha characters keeps the message readable)

3. "If the shift is 3 and the letter is 'x', what should the result be?"
   (Walk them through the wrap-around problem: x->y->z->a. This motivates modular arithmetic)

4. "How will the user choose between encoding and decoding?"
   (Discuss a simple menu and how the choice maps to a positive or negative shift)

## Implementation Guide
1. Write a `caesar()` function that takes a message, a shift amount, and a direction.
2. Inside the function, iterate through each character of the message.
3. For each character: if it is a letter, shift it using `ord()`, apply modulo 26 for wrap-around, convert back with `chr()`. If not a letter, keep it unchanged.
4. Build up the result string character by character and return it.
5. In the main program, ask the user for a message, a shift number, and whether to encode or decode.
6. Call the function and display the result.
7. Allow the user to go again or quit.

## Design Tips
- Handle uppercase and lowercase separately: convert the character's position relative to `ord('a')` or `ord('A')`, apply the shift with modulo, then convert back.
- Make the shift direction a simple sign flip: encode adds, decode subtracts. This keeps the logic in one function.
- Validate the shift value -- it should be an integer between 1 and 25. A shift of 0 or 26 does nothing.
- Show both the original and encoded message side by side so the user can verify the result.
- This is a great day to reinforce the concept of functions that return values rather than printing directly.

## Common Mistakes
- **Not handling wrap-around**: Letters near the end of the alphabet (x, y, z) produce garbage characters when shifted past 'z'. The fix is `(position + shift) % 26`. If they have not seen `%` before, take time to explain it with a clock analogy.
- **Forgetting to preserve spaces and punctuation**: The entire message turns into an unreadable blob. Remind them to check `char.isalpha()` before shifting and pass non-alpha characters through unchanged.
- **Writing separate encode and decode functions with duplicated logic**: This works but misses the key insight. Show them that decode is just encode with `-shift`, then refactor into one function.

## Extension Ideas
- Add a brute-force decoder that tries all 26 shifts and prints each one so the user can spot the correct message.
- Support encoding entire files by reading from and writing to text files.
- Implement a more advanced cipher (e.g., Vigenere) that uses a keyword instead of a single number.

## When They're Stuck
- **"It works for most letters but gives weird symbols for x, y, or z"**: They are not using modulo. Walk through the math: if 'z' is position 25 and shift is 3, then 25+3=28. Without modulo that maps to a non-letter ASCII code. With `% 26` it wraps to 2, which is 'c'.
- **"How do I make decoding the reverse of encoding?"**: Show them that if encoding shifts forward by 5, decoding shifts forward by -5 (or equivalently by 21). They can pass a negative shift to the same function.
- **"My spaces disappear"**: They are only appending shifted characters and skipping everything else. Add an `else` branch that appends the original character when `isalpha()` is False.
