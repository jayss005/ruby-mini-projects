# Mastermind Game 🎯

A command-line implementation of the classic **Mastermind** board game, written in Ruby.

---

## 📖 About the Game

Mastermind is a code-breaking game where the computer generates a secret 4-color code and you have **12 attempts** to guess it correctly. After each guess, you receive feedback telling you how close your guess was.

---

## 🎮 How to Play

1. The computer randomly generates a secret code made up of **4 colors**
2. You enter your guess as a 4-letter string (e.g. `RGBY`)
3. After each guess, you get feedback:
   - **correct position** → the color is correct AND in the right spot
   - **correct color** → the color exists in the code but is in the wrong spot
4. Use the feedback to narrow down the secret code
5. Guess the code within **12 attempts** to win!

---

## 🎨 Available Colors

| Letter | Color  |
|--------|--------|
| R      | Red    |
| G      | Green  |
| B      | Blue   |
| Y      | Yellow |
| O      | Orange |
| P      | Purple |

---

## 💡 Example Round

```
Secret code (hidden): R G B Y

Your guess:  G G B P
Feedback: 1 correct position(s), 0 correct color(s)

Explanation:
- Position 1: R vs G → wrong
- Position 2: G vs G → ✅ correct position
- Position 3: B vs B → ✅ correct position  (wait, that's 2!)
- Position 4: Y vs P → wrong
```

```
Your guess:  R G B Y
Feedback: 4 correct position(s), 0 correct color(s)
Congratulations! You've guessed the secret code in 2 attempt(s)!
```

---

## ▶️ How to Run

Make sure you have **Ruby** installed, then run:

```bash
ruby mastermind.rb
```

---

## 🔁 Play Again

After each game ends (win or loss), you'll be asked:

```
Play again? (y/n)
```

- Enter `y` to start a new game with a new secret code
- Enter `n` to exit

---

## 🏗️ Project Structure

```
mastermind.rb
│
├── Game    → Controls game flow, attempts, and feedback display
├── Code    → Generates the secret code and checks guesses
└── Player  → Handles user input and validates guesses
```

---

## ✅ Input Rules

- Your guess must be **exactly 4 characters**
- Each character must be one of: `R, G, B, Y, O, P`
- Invalid inputs will prompt you to try again

**Valid:**   `RGBY`, `OOPS` ❌ → `OOPP` ✅  
**Invalid:** `RGB` (too short), `RGBX` (X is not a valid color)

---

## 🧠 Strategy Tips

- Start with a guess that uses 4 different colors to gather maximum information
- Pay close attention to both the **correct position** and **correct color** counts
- Eliminate colors that give 0 feedback entirely
- You have 12 attempts — take your time and think it through!

---

## 📋 Requirements

- Ruby 2.0 or higher
- No external gems required — uses only Ruby's standard library