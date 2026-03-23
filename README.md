# Woven Monopoly Simulation (Ruby)

## 📌 Overview

This project implements a simplified Monopoly-style board game simulation in Ruby.
The application reads a game board and dice rolls from JSON files, simulates gameplay deterministically, and outputs the final results.

The solution is designed with **clean architecture, extensibility, and maintainability** in mind, similar to production-level code.

---

## 🚀 Features

* Turn-based gameplay with multiple players
* Property purchasing and ownership tracking
* Rent calculation with colour set bonus (double rent)
* Passing GO reward system
* Immediate game termination on bankruptcy
* Board wrap-around logic
* Clean and readable object-oriented design

### 💡 Enhancements (Beyond Requirements)

* Configurable players (not hardcoded)
* Strategy pattern for rent calculation
* CLI support using `OptionParser`
* Input validation for safer execution
* Basic RSpec tests included (all passing)
* Structured Git commit history showing development progression

---

## 🛠 Tech Stack

* Ruby
* JSON parsing
* RSpec (for testing)

---

## ▶️ How to Run

### Basic Usage

```bash
ruby main.rb -b data/board.json -r data/rolls_1.json
```

### With Custom Players

```bash
ruby main.rb -b data/board.json -r data/rolls_1.json -p Alice,Bob,Charlie
```

### Help

```bash
ruby main.rb -h
```

---

## 🧪 Running Tests

Install RSpec (if not already installed):

```bash
gem install rspec
```

Run tests:

```bash
rspec
```

---

## 📂 Project Structure

```
woven_monopoly/
├── main.rb              # Entry point (CLI support)
├── game.rb              # Core game logic
├── player.rb            # Player model
├── board.rb             # Board and space management
├── property.rb          # Property model
├── rent_strategy.rb     # Strategy pattern for rent calculation
├── data/                # Input JSON files
├── spec/                # RSpec tests
└── README.md
```

---

## 🧠 Design Decisions

### 1. Separation of Concerns

* Game flow (`Game`) is separated from business rules (`RentStrategy`)
* Improves readability and maintainability

### 2. Strategy Pattern

* Rent calculation is abstracted using a strategy class
* Allows easy extension (e.g., different rent rules)

### 3. Configurable Design

* Players and rules are not hardcoded
* Supports easy changes without modifying core logic

### 4. Defensive Programming

* Prevents invalid states (e.g., negative balances)
* Input validation for file handling

### 5. Testability

* Core logic structured to support unit testing
* Basic RSpec tests implemented

---

## 🏆 Assumptions

* All players must buy unowned properties
* Game ends immediately when a player cannot pay
* Dice rolls are deterministic and provided via input files

---

## 👤 Author

Krushi Khetani
