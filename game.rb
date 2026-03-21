require_relative "player"
require_relative "board"

class Game
  GO_SALARY = 1

  def initialize(board_file, rolls_file)
    @board = Board.new(board_file)
    @rolls = load_rolls(rolls_file)
    @players = init_players
    @current_roll_index = 0
    @game_over = false
  end

  def play
  until @game_over || @current_roll_index >= @rolls.length
    @players.each do |player|
      take_turn(player)

      if @game_over
        print_results
        return   
      end
    end
  end

  print_results
end

  private

  def load_rolls(file)
    require "json"
    JSON.parse(File.read(file))
  end

  def init_players
    ["Peter", "Billy", "Charlotte", "Sweedal"].map { |name| Player.new(name) }
  end

  def take_turn(player)
    roll = @rolls[@current_roll_index]
    @current_roll_index += 1

    passed_go = player.move(roll, @board.size)
    player.money += GO_SALARY if passed_go

    current_space = @board.space_at(player.position)

    return if current_space.type == "GO"

    if current_space.type == "property"
  if !current_space.owned?
    player.buy_property(current_space)
  else
    handle_rent(player, current_space)
  end
end

    if player.bankrupt?
  @game_over = true
  return  
end
  end

  def handle_rent(player, property)
    owner = property.owner
    return if owner == player

    rent = property.price

    if owns_full_set?(owner, property.colour)
      rent *= 2
    end

    success = player.pay(rent, owner)

unless success
  @game_over = true
  return
end
end

  def owns_full_set?(player, colour)
    properties = @board.properties_by_colour(colour)
    properties.all? { |p| p.owner == player }
  end

  def winner
    @players.max_by(&:money)
  end

  def print_results
    puts "\n🏆 Game Results"
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