# Game class handles the main simulation logic
# Refactored for extensibility:
# - Configurable players
# - Separated business rules (Rules class)
# - Config-driven settings

require_relative "player"
require_relative "board"
require_relative "rules"

class Game
  # Default player configuration (can be overridden)
  DEFAULT_PLAYERS = ["Peter", "Billy", "Charlotte", "Sweedal"]

  # Configurable game settings
  CONFIG = {
    go_salary: 1
  }

  def initialize(board_file, rolls_file, player_names = DEFAULT_PLAYERS)
    @board = Board.new(board_file)
    @rolls = load_rolls(rolls_file)
    @players = init_players(player_names)
    @current_roll_index = 0
    @game_over = false
  end

  # Main game loop
  def play
    until @game_over || @current_roll_index >= @rolls.length
      @players.each do |player|
        take_turn(player)

        # Stop immediately when game ends
        if @game_over
          print_results
          return
        end
      end
    end

    print_results
  end

  private

  # Load dice rolls from JSON file
  def load_rolls(file)
    require "json"
    JSON.parse(File.read(file))
  end

  # Initialize players dynamically
  def init_players(player_names)
    player_names.map { |name| Player.new(name) }
  end

  # Execute a single player's turn
  def take_turn(player)
    roll = @rolls[@current_roll_index]
    @current_roll_index += 1

    # Move player and check if GO is passed
    passed_go = player.move(roll, @board.size)
    player.money += CONFIG[:go_salary] if passed_go

    current_space = @board.space_at(player.position)

    # Skip GO tile
    return if current_space.type == "GO"

    # Handle property logic
    if current_space.type == "property"
      if !current_space.owned?
        player.buy_property(current_space)
      else
        handle_rent(player, current_space)
      end
    end

    # Check bankruptcy
    if player.bankrupt?
      @game_over = true
      return
    end
  end

  # Handle rent payment using Rules module
  def handle_rent(player, property)
    owner = property.owner
    return if owner == player

    rent = Rules.calculate_rent(property, @board)

    success = player.pay(rent, owner)

    # End game if player cannot pay
    unless success
      @game_over = true
      return
    end
  end

  # Determine winner (highest money)
  def winner
    @players.max_by(&:money)
  end

  # Print final game results
  def print_results
    puts "\nGame Results"
    puts "--------------"
    puts "Winner: #{winner.name}"

    puts "\nFinal Money:"
    @players.each do |p|
      puts "#{p.name}: $#{p.money}"
    end

    puts "\nFinal Positions:"
    @players.each do |p|
      space = @board.space_at(p.position)
      puts "#{p.name}: #{space.name}"
    end
  end
end