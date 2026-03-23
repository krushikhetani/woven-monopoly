# Represents the game board
# Loads and stores all spaces (properties and GO)

require_relative "property"
require "json"

class Board
  attr_reader :spaces

  def initialize(file_path)
    data = JSON.parse(File.read(file_path))
    @spaces = data.map { |space| Property.new(space) }
  end

  def size
    @spaces.size
  end

  # Get space at specific position
  def space_at(position)
    @spaces[position]
  end

  # Get all properties of a given colour
  def properties_by_colour(colour)
    @spaces.select { |s| s.colour == colour }
  end
end