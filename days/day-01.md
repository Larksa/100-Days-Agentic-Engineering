# Day 01: Band Name Generator

## What They're Building
A program that asks for a city name and a pet name, then combines them into a band name.

## Concepts Introduced
- Variables: storing data with descriptive names
- `input()`: getting text from the user
- `print()`: displaying output
- String concatenation: combining strings with `+` or commas
- No prerequisites -- this is Day 1

## Design Questions to Ask
1. "What inputs does your program need from the user?"
   - a) Just a name  b) A city and a pet name  c) A number and a word
   (Answer: b -- two inputs create more interesting combinations)

2. "How should the two words appear in the final band name?"
   - a) Jammed together: 'MelbourneRex'  b) With a space: 'Melbourne Rex'  c) With a dash: 'Melbourne-Rex'
   (Answer: b is standard, but discuss how the separator is a design choice)

3. "Which is a better variable name: `x` or `city_name`?"
   (Guide them toward descriptive names -- readability is the first habit to build)

## Implementation Guide
1. Greet the user and explain what the program does.
2. Ask for the city name using `input()` and store it in a variable.
3. Ask for the pet name and store it in a second variable.
4. Combine the two variables with a space between them.
5. Print the result with a friendly message like "Your band name is: ..."

## Design Tips
- Encourage descriptive variable names (`city_name` not `c`).
- Show how `input("prompt: ")` keeps the prompt and cursor on the same line.
- Format the output clearly: "Your band name could be: Melbourne Rex" rather than just the raw string.

## Common Mistakes
- **Forgetting the space between words**: `city + pet` gives "MelbourneRex". Guide them to `city + " " + pet`.
- **Not handling empty input**: If they press Enter with no text, the band name looks broken. Flag this as something they will learn to fix later.
- **Hardcoding values**: If they write `print("Melbourne Rex")` instead of using variables, explain why dynamic input matters.

## Extension Ideas
- Add a third ingredient (favourite colour, lucky number) for wilder names.
- Generate multiple band names and let the user pick their favourite.

## When They're Stuck
- **"My two words print on separate lines"**: They are using two `print()` calls. Show `print(city + " " + pet)` or `print(city, pet)`.
- **"How do I make it run again?"**: They want a loop but have not learned loops yet. Show them they can re-run the script. Mention loops are coming soon.
- **"Nothing happens when I run it"**: They stored the concatenation but forgot to `print()` it.
