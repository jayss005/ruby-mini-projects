# Hangman — Ruby CLI Game

A command-line Hangman game written in Ruby, built with clean object-oriented design across four focused classes.

---

## Overview

The player guesses a secret word one letter at a time before running out of lives. The word is randomly selected from a dictionary file. The game supports saving and loading so you can pick up exactly where you left off.

---

## Features

- Random word selection from a dictionary file (5–12 characters)
- Live board showing guessed letters and blanks e.g. `_ r o g r a _ _ i n g`
- Tracks correct and incorrect guesses separately
- 6 lives by default before the game is lost
- Save mid-game and resume later
- Overwrite protection when a save file already exists
- Input validation — only accepts single letters

---

## Requirements

- Ruby 2.7 or higher
- A file called `Words.txt` in the same directory as `hangman.rb`, with one word per line
- No external gems — uses only Ruby's standard library

---

## How to Run
```bash
ruby hangman.rb
```

You'll see the main menu:
```
Welcome to Hangman!
1. New Game
2. Load Saved Game
3. Quit
```

---

## Project Structure

| Class | Responsibility |
|-------|---------------|
| `WordLoader` | Reads dictionary, filters by length, returns a random word |
| `Game` | Owns all game state, logic, win/lose detection, and the play loop |
| `Display` | Handles all terminal output — board, status, results |
| `SaveManager` | Saves and loads the Game object using Marshal |

---

## Gameplay

**Each turn shows:**
- The word with correctly guessed letters revealed
- Wrong guesses so far
- Lives remaining

Type a single letter and press Enter. The game is case-insensitive. Type `save` at any turn to save and exit.

**You win** by guessing all letters before running out of lives.
**You lose** after 6 incorrect guesses — the word is always revealed at the end.

---

## Save & Load

Type `save` during your turn to freeze the game to a file called `save.dat`. Select option 2 from the main menu to restore it — same word, same guesses, same lives remaining.

If a save already exists when starting a new game, you'll be asked before it gets overwritten.

---

## Example Session
```
_ _ _ _ _ _ _
Wrong guesses:
Lives remaining: 6
Enter a letter or 'save': e

_ _ _ _ _ _ _
Wrong guesses: e
Lives remaining: 5
Enter a letter or 'save': a

_ a _ _ _ _ a
Wrong guesses: e
Lives remaining: 5
```

---

## Technical Notes

- **Word loading** — `Words.txt` is filtered to 5–12 character words and one is picked with `.sample`
- **Serialization** — Ruby's `Marshal` dumps the entire `Game` object to binary in one line, no manual field extraction needed
- **Input validation** — regex `/^[a-z]$/` ensures exactly one lowercase letter per turn
- **File paths** — `__dir__` is used throughout so the game works regardless of where you run it from

---

## Author

Built as a Ruby learning project practising OOP, file I/O, serialization, input validation, and clean class separation.