---
blocks:
  - staged-build
  - bold-iteration
  - show-the-code
---

# Day 11: Blackjack (Capstone)

## What They're Building
A full Blackjack card game with dealer AI -- the capstone project of the beginner phase that combines everything learned in Days 1-10.

This is the most complex project so far. Take time at the start to acknowledge that and frame it as a milestone. Everything they have learned -- variables, conditionals, loops, functions, lists, dictionaries, and error handling -- comes together here. If they can build this, they have a solid foundation in Python fundamentals.

## Concepts Introduced
- Complex algorithm design: the Ace-handling logic requires thinking through multiple scenarios
- Dealer AI: implementing a rule-based agent (hit until 17 or higher)
- Combining all previous concepts into a single cohesive program
- Game state management across multiple phases (deal, player turn, dealer turn, resolution)
- Prerequisites: everything from Days 1-10 (functions, lists, loops, conditionals, random, dictionaries)

## Design Questions to Ask
1. "What data structure should represent a card? And what about the deck?"
   - a) A list of numbers 1-13
   - b) A list of tuples like ('Hearts', 'Ace') or a list of integers representing card values
   - c) A dictionary mapping card names to values
   (Answer: for a first implementation, a simple list of values like `[11, 2, 3, 4, 5, 6, 7, 8, 9, 10, 10, 10, 10]` works well. Discuss that face cards all equal 10 and Ace starts at 11. More advanced representations can come as extensions)

2. "An Ace can be worth 11 or 1. When should it change from 11 to 1?"
   (This is the hardest logic in the project. Guide them: an Ace should become 1 when the hand total exceeds 21 and there is an Ace currently counted as 11. Multiple Aces may need adjusting independently)

3. "When does the dealer stop taking cards?"
   - a) When the dealer beats the player
   - b) When the dealer reaches 17 or higher
   - c) When the dealer has 5 cards
   (Answer: b -- the standard rule is the dealer must hit on 16 or below and stand on 17 or above. This is a simple while loop with a clear condition)

4. "What is the difference between a 'blackjack' and just having 21?"
   (A blackjack is specifically 21 with exactly 2 cards -- an Ace and a 10-value card. It usually pays more and beats a regular 21. This distinction is an important edge case)

5. "What are all the ways a round can end?"
   (Walk through: player busts, player stands and dealer plays, dealer busts, compare totals, blackjack, tie/push. Listing these upfront prevents missing win conditions during coding)

## Implementation Guide
1. **Build the deck**: Create a function that returns a list of card values. Decide whether to use infinite deck (draw randomly each time) or a finite shuffled deck.
2. **Deal cards**: Write a `deal_card()` function that picks a random card. Deal two cards each to the player and dealer. The dealer's first card is hidden.
3. **Calculate hand value**: Write a `calculate_score()` function that sums the hand and handles Ace adjustment. If the total is over 21 and the hand contains an 11 (Ace), change the 11 to a 1.
4. **Check for blackjack**: If a hand has exactly 2 cards and totals 21, that is a blackjack. Check both player and dealer immediately after dealing.
5. **Player turn**: Loop asking hit or stand. On hit, add a card and recalculate. If over 21, the player busts and the round ends immediately.
6. **Dealer turn**: Once the player stands, reveal the dealer's hidden card. The dealer hits while their total is below 17. If the dealer busts, the player wins.
7. **Compare scores**: If neither busted, the higher total wins. Equal totals are a push (tie).
8. **Display and replay**: Show both hands and the outcome clearly, then offer to play again.

## Design Tips
- **Break it into functions early.** This project is too complex to write as one long script. At minimum: `deal_card()`, `calculate_score()`, `compare()`, `play_game()`. Frame this as the real lesson -- they are learning to decompose a problem.
- **Handle the Ace with a while loop, not just an if.** A hand with two Aces dealt as 11+11=22 needs both converted. Use: `while total > 21 and 11 in hand: hand.remove(11); hand.append(1)`.
- **Show the game state clearly.** After each action, print both hands (with the dealer's first card hidden during the player's turn). Something like: `Your hand: [10, 7], score: 17 | Dealer showing: [8, ?]`.
- **Test edge cases explicitly.** Manually test: player blackjack, dealer blackjack, both blackjack, player bust, dealer bust, tie, Ace adjustment with multiple Aces.
- **Keep the game loop separate from the game logic.** The outer loop handles "play again?" while the inner logic handles a single round. This separation makes the code much cleaner.
- **Start simple, then layer in complexity.** Get a basic version working (deal, hit/stand, compare) before adding blackjack detection, Ace handling, and betting.

## Common Mistakes
- **Ace is always 11, causing busts that should not happen**: This is the most common bug. The student forgets to adjust Aces downward. Emphasise the `while` loop approach: keep converting 11s to 1s as long as the hand is over 21 and 11s remain.
- **Using an infinite deck but not realising it**: Drawing randomly from a static list means the same card can appear more than four times. For a first version this is acceptable, but point out that a real deck is finite. If they want realism, they should shuffle a full deck list and pop cards from it.
- **Dealer hits when they should not**: The dealer's while loop condition is wrong -- perhaps `while total < 21` instead of `while total < 17`. Clarify the rule: stand on 17 or above, hit on 16 or below.
- **Not distinguishing blackjack from regular 21**: A player who hits to reach 21 with three cards should not be treated the same as a natural blackjack (2 cards totalling 21). Check both the total and the hand length.

## Extension Ideas
- **Betting system**: Give the player a starting balance (e.g., 1000). Let them bet before each round. Blackjack pays 1.5x, regular win pays 1x, push returns the bet.
- **Multiple players**: Let 2-3 players take turns against the same dealer. This tests their ability to manage separate hand states.
- **ASCII art cards**: Display cards visually using text art instead of just printing numbers. This is a fun formatting challenge.
- **Card counting indicator**: After each round, show a running count statistic (high cards vs low cards remaining) as a learning tool about probability.

## When They're Stuck
- **"The Ace is always 11 and my hand keeps busting"**: Walk them to the Ace adjustment logic. Print the hand before and after adjustment so they can see it working: `Hand before: [11, 5, 11], total: 27. Adjusting... Hand after: [1, 5, 11], total: 17`. Emphasise the `while` loop -- a single `if` only fixes one Ace.
- **"The dealer keeps hitting forever"**: Print the dealer's total inside the while loop so they can watch it. The condition is probably wrong. It should be `while calculate_score(dealer_hand) < 17`. A common error is using `<=` 17, which makes the dealer hit on 17 when they should stand.
- **"How do I check for blackjack versus regular 21?"**: Blackjack requires exactly two conditions: the hand has 2 cards AND the total is 21. Write a helper: `def is_blackjack(hand): return len(hand) == 2 and calculate_score(hand) == 21`. Check for it right after the initial deal, before the player's turn begins.
- **"Everything works but the game flow feels wrong"**: They probably have the dealer's turn running even when the player busted. Add an early return: if the player busts, skip the dealer's turn entirely and go straight to the loss message. Map out the flow on paper: deal -> check blackjacks -> player turn -> if bust, end -> dealer turn -> if bust, end -> compare.
- **"I don't know where to start -- this is too big"**: This is normal and expected for the capstone. Break it down: start with just dealing two cards and printing them. Then add calculating the score. Then add the player's hit/stand loop. Then the dealer. Then win/loss logic. Build one layer at a time and test each before moving on. This is how professional developers work.
