# Day 06: Robot Simulator

## What They're Building
A text-based robot simulator where the robot moves on a grid, controlled by functions the student defines like `move_forward()`, `turn_left()`, and `turn_right()`.

## Concepts Introduced
- Defining functions with `def`
- Calling functions: the distinction between defining and executing
- Function reuse: write once, call many times
- `while` loops: indefinite repetition
- Combining functions into higher-level actions (abstraction)
- Prerequisites: Day 5 (`for` loops), Day 3 (`if`/`else`)

## Design Questions to Ask
1. "To make a robot walk in a square, what are the steps in plain English?"
   (Move forward, turn right, repeat four times -- this motivates functions)

2. "You described the same two steps four times. What if you could name that pattern?"
   - a) Copy-paste four times  b) Put it in a function, call it four times
   (Answer: b -- the core motivation for functions)

3. "What basic actions should your robot have?"
   - a) Just move  b) Move forward, turn left, turn right  c) Move, jump, fly, teleport
   (Answer: b -- complex actions are built from simple primitives)

4. "How will you represent where the robot is and which direction it faces?"
   (Grid position `[x, y]` and a direction like `"north"`)

## Implementation Guide
1. Set up state: position `[0, 0]` and direction `"north"`.
2. Define `move_forward()`: update position based on current direction.
3. Define `turn_left()` and `turn_right()`: change the direction.
4. Define `show_status()`: print position and direction.
5. Create a `while True` loop: show status, ask for a command, call the matching function, break on "quit".
6. Define `walk_square()` combining basic functions to demonstrate abstraction.

## Design Tips
- Have them write robot logic without functions first, then refactor. The before-and-after shows exactly why functions exist.
- Use verb-based names: `move_forward()`, `turn_left()`, not `forward_thing()`.
- Build complex behaviours from simple ones: `walk_square()` calls `move_forward()` and `turn_right()` four times. This is abstraction.
- Compare `while` to `for`: `for` runs a set number of times, `while` runs until a condition changes.

## Common Mistakes
- **Defining but never calling**: They write `def move_forward():` but nothing happens. Defining is writing the recipe; calling is cooking the meal.
- **Indentation in function bodies**: Every line inside `def` must be indented. If they unindent accidentally, code falls outside the function.
- **Scope issues**: Variable defined inside a function used outside gives `NameError`. Use a list for position (`robot_pos = [0, 0]`) since lists are mutable and changes persist across function calls.

## Extension Ideas
- Add grid boundaries (e.g., 10x10) with warnings when the robot tries to walk off the edge.
- Place obstacles on the grid that the robot must navigate around.

## When They're Stuck
- **"Defined function but nothing happens"**: They never called it. Show the two steps: `def` creates the recipe, `move_forward()` executes it.
- **"What's the difference between defining and calling?"**: Defining is saving a contact in your phone. Calling is dialling the number. Saving does not make a call.
- **"Robot position doesn't update"**: Likely creating a local variable instead of modifying the global list. Use a list for position since lists are mutable inside functions.
- **"While loop never stops"**: Forgot the `break` or quit condition. Walk through: "What makes this loop stop? Where does that check happen?"
