# Day 07: Hangman

## What They're Building
A word-guessing game where the player tries to reveal a hidden word one letter at a time before running out of lives.

## Concepts Introduced
- `while` loops: keeping a game running until a win/loss condition is met (the "game loop")
- String indexing and checking membership with the `in` operator
- List manipulation: building and updating a display list of underscores and revealed letters
- Prerequisites: functions (Day 6), for loops and lists (Day 5), if/else (Day 3)

## Design Questions to Ask
1. "How will you show the player which letters they have guessed correctly?"
   - a) Print the whole word with blanks for missing letters
   - b) Just tell them how many letters are correct
   - c) Print only the correct letters with no indication of position
   (Answer: a -- an underscore display like `_ e _ _ o` gives positional feedback and feels like real Hangman)

2. "What data do you need to track throughout the game?"
   - a) Just the word and the number of lives
   - b) The word, guessed letters, remaining lives, and the current display
   - c) Only the guessed letters
   (Answer: b -- walk them through why each piece of state matters)

3. "What should happen if the player guesses a letter they already tried?"
   (Guide them to keep a list of past guesses and warn the player without penalising them)

4. "How does the game know when the player has won?"
   (Help them see that winning means no underscores remain in the display)

## Implementation Guide
1. Choose a random word from a word list using `random.choice()`.
2. Create a display list of underscores matching the word length.
3. Set a lives counter (typically 6).
4. Start a `while` loop that continues as long as lives remain and underscores exist in the display.
5. Each iteration: get a letter guess, convert to lowercase, check if already guessed.
6. If the letter is in the word, loop through the word and reveal matching positions in the display.
7. If the letter is not in the word, decrease lives and give feedback.
8. After the loop, check win or loss and print the appropriate message.
9. Offer to play again.

## Design Tips
- Normalise all input to lowercase immediately so comparisons are consistent.
- Use a list (not a string) for the display -- lists are mutable, strings are not.
- Print the current state clearly after every guess: the display, remaining lives, and letters already tried.
- Consider word difficulty levels (short words for easy, longer for hard) as a natural extension.
- A simple ASCII art progression for the hangman figure makes the game far more engaging.

## Common Mistakes
- **Not updating the display after a correct guess**: The student loops through the word to find matches but forgets to replace the underscore at the matching index. Remind them to use `enumerate()` or index tracking.
- **Checking if the letter is in the already-guessed list instead of in the word**: The condition logic gets swapped. Walk through the order: first check if already guessed, then check if in the word.
- **Forgetting to decrease lives on a wrong guess**: The loop runs but lives never change, so the game never ends. Have them trace through one wrong guess step by step.

## Extension Ideas
- Add ASCII art that builds the hangman figure stage by stage.
- Implement difficulty levels that change word length and number of lives.
- Add a hint system that reveals one letter at the cost of a life.

## When They're Stuck
- **"The underscores never update even when I guess correctly"**: They are likely creating a new display list each loop iteration instead of updating the existing one, or their index logic is off. Have them add a `print()` inside the letter-checking loop to see what is happening at each position.
- **"The game does not end when I run out of lives"**: Their `while` condition probably only checks for underscores remaining and not lives. Remind them the loop needs both conditions: `while lives > 0 and "_" in display`.
- **"It lets me guess the same letter over and over"**: They need to check against a guessed-letters list before processing the guess. Show them how to append each guess and check membership with `in`.
