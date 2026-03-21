require_relative "game"

if ARGV.length < 2
  puts "Usage: ruby main.rb <board.json> <rolls.json>"
  exit
end

board_file = ARGV[0]
rolls_file = ARGV[1]

game = Game.new(board_file, rolls_file)
game.play