# Rules module encapsulates all business logic related to the game
# This keeps Game class clean and makes rules easier to modify/extend

class Rules
  # Calculate rent for a property
  def self.calculate_rent(property, board)
    rent = property.price

    # Double rent if owner owns full colour set
    if owns_full_set?(property.owner, property.colour, board)
      rent *= 2
    end

    rent
  end

  # Check if player owns all properties of a given colour
  def self.owns_full_set?(player, colour, board)
    properties = board.properties_by_colour(colour)
    properties.all? { |p| p.owner == player }
  end
end