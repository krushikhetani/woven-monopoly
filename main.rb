# Entry point for the Woven Monopoly simulation
# Takes board file and rolls file as input arguments

require_relative "game"

# Ensure correct usage
if ARGV.length < 2
  puts "Usage: ruby main.rb <board.json> <rolls.json>"
  exit
end

board_file = ARGV[0]
rolls_file = ARGV[1]

# Initialize and start the game
game = Game.new(board_file, rolls_file)
game.play