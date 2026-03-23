# Woven Monopoly Simulation (Ruby)

## Overview

This project implements a simplified Monopoly-style board game simulation in Ruby.
The program reads input data from JSON files and simulates gameplay including movement, property ownership, rent payments, and bankruptcy conditions.

## Features

* Turn-based gameplay for multiple players
* Property purchasing and ownership tracking
* Rent calculation with colour set bonuses
* Passing GO reward system
* Immediate game termination on bankruptcy
* Clean object-oriented design

## Tech Stack

* Ruby
* JSON parsing

## How to Run

```bash
ruby main.rb data/board.json data/rolls_1.json
```

## Project Structure

* `main.rb` – Entry point
* `game.rb` – Core game logic
* `player.rb` – Player behavior
* `board.rb` – Board management
* `property.rb` – Property model
* `data/` – Input files

## Design Decisions

* Used OOP principles for modularity and clarity
* Prevented invalid states (e.g., negative balances)
* Implemented early termination for bankruptcy

## Author

Krushi Khetani
