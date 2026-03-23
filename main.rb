# Entry point for Woven Monopoly simulation
# Supports CLI arguments using OptionParser

require_relative "game"
require "optparse"

options = {}

OptionParser.new do |opts|
  opts.banner = "Usage: ruby main.rb -b <board.json> -r <rolls.json> [options]"

  opts.on("-b", "--board FILE", "Board JSON file") do |file|
    options[:board] = file
  end

  opts.on("-r", "--rolls FILE", "Rolls JSON file") do |file|
    options[:rolls] = file
  end

  opts.on("-p", "--players x,y,z", Array, "Custom player names (comma separated)") do |list|
    options[:players] = list
  end

  opts.on("-h", "--help", "Show help") do
    puts opts
    exit
  end
end.parse!

# Validate required inputs
if options[:board].nil? || options[:rolls].nil?
  puts "❌ Missing required arguments"
  puts "Usage: ruby main.rb -b data/board.json -r data/rolls_1.json"
  exit
end

# Validate file existence
unless File.exist?(options[:board]) && File.exist?(options[:rolls])
  puts "❌ One or more input files do not exist"
  exit
end

# Use default players if not provided
players = options[:players] || Game::DEFAULT_PLAYERS

# Initialize and run game
game = Game.new(options[:board], options[:rolls], players)
game.play