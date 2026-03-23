# Game class handles the main simulation logic
# Controls player turns, movement, property logic, and game termination

require_relative "player"
require_relative "board"

class Game
  GO_SALARY = 1  # Money awarded when passing GO

  def initialize(board_file, rolls_file)
    @board = Board.new(board_file)
    @rolls = load_rolls(rolls_file)
    @players = init_players
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

  # Initialize players
  def init_players
    ["Peter", "Billy", "Charlotte", "Sweedal"].map { |name| Player.new(name) }
  end

  # Execute a single player's turn
  def take_turn(player)
    roll = @rolls[@current_roll_index]
    @current_roll_index += 1

    # Move player and check if GO is passed
    passed_go = player.move(roll, @board.size)
    player.money += GO_SALARY if passed_go

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

  # Handle rent payment between players
  def handle_rent(player, property)
    owner = property.owner
    return if owner == player

    rent = property.price

    # Double rent if owner has full set
    if owns_full_set?(owner, property.colour)
      rent *= 2
    end

    success = player.pay(rent, owner)

    # End game if player cannot pay
    unless success
      @game_over = true
      return
    end
  end

  # Check if player owns all properties of a colour
  def owns_full_set?(player, colour)
    properties = @board.properties_by_colour(colour)
    properties.all? { |p| p.owner == player }
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