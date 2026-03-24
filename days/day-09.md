---
blocks:
  - staged-build
  - bold-iteration
---

# Day 09: Secret Auction

## What They're Building
A blind auction program where multiple bidders secretly enter their bids, and the program announces the highest bidder as the winner.

## Concepts Introduced
- Dictionaries: storing key-value pairs (bidder name mapped to bid amount)
- Adding entries to a dictionary
- Iterating over dictionaries to find the maximum value and its associated key
- `max()` function and manual max-finding logic
- Prerequisites: while loops (Day 7), input/output (Day 1)

## Design Questions to Ask
1. "How should you store each person's name alongside their bid?"
   - a) Two separate lists -- one for names, one for bids
   - b) A dictionary where the name is the key and the bid is the value
   - c) A single list of strings like "Alice:150"
   (Answer: b -- introduce dictionaries as the natural structure for paired data. Mention that parallel lists work but are fragile)

2. "How do you keep each bid secret from the other bidders?"
   - a) Ask everyone to close their eyes
   - b) Clear the terminal screen after each bid
   - c) It does not matter
   (Answer: b -- discuss the user experience and introduce screen clearing as a simple UX technique)

3. "What happens if two people bid the same amount?"
   (There is no single right answer. Discuss options: first bidder wins, last bidder wins, or announce a tie. Let the student choose and implement their rule)

4. "How do you find the winner from a dictionary of bids?"
   (Walk them through iterating over the dictionary and tracking the highest value and its key)

## Implementation Guide
1. Create an empty dictionary to store bids.
2. Start a `while` loop that asks: bidder name, bid amount, and whether there are more bidders.
3. Convert the bid to a number and store it in the dictionary with the name as the key.
4. Clear the screen between bidders (using `os.system("clear")` on Mac/Linux or `os.system("cls")` on Windows, or simply printing many blank lines).
5. When no more bidders, loop through the dictionary to find the entry with the highest bid.
6. Announce the winner with their name and bid amount.

## Design Tips
- Validate that the bid is a positive number. Use `try/except` or a simple check to reject nonsense input.
- Print a confirmation after each bid ("Your bid has been recorded") so the bidder knows it worked before the screen clears.
- Consider what happens if someone enters a name that already exists in the dictionary -- it will silently overwrite the previous bid. Either warn the user or append a number to duplicate names.
- Keep the winner-finding logic as its own function. This reinforces the habit of separating concerns.
- Dictionaries are new today -- take time to explain the syntax and let the student experiment with adding, accessing, and printing dictionary contents before diving into the full project.

## Common Mistakes
- **Overwriting dictionary entries instead of adding new ones**: If two people type the same name, the second bid replaces the first. Help them spot this by testing with duplicate names and deciding how to handle it.
- **Finding the max bid value but losing track of who placed it**: They use `max(bids.values())` to find the amount but then cannot get the name. Show them how to iterate with `.items()` to keep both together, or use `max(bids, key=bids.get)`.
- **Not clearing the screen between bidders**: Every bid is visible on screen. Show them the `os` module approach and explain it is a simple terminal trick, not complex programming.

## Extension Ideas
- Add a minimum bid requirement and reject bids below it.
- Show a ranked list of all bidders (without amounts) after the auction ends, then reveal only the winner.
- Add a reserve price -- if no bid meets the reserve, announce that the item was not sold.

## When They're Stuck
- **"I can store bids but cannot find the winner"**: They have the dictionary but do not know how to search it. Walk them through a manual approach: set `winner = ""` and `highest = 0`, then loop through `.items()` comparing each bid to `highest`.
- **"How do I clear the screen in Python?"**: Show them `import os` then `os.system("clear")`. Explain this sends a command to the terminal. If it does not work on their system, printing 50 blank lines with `print("\n" * 50)` is a simple fallback.
- **"The bid amount is being stored as a string and comparisons are wrong"**: They forgot to convert the input to `int()` or `float()`. String comparison of "9" > "100" is True because strings compare character by character. This is a valuable debugging moment.
