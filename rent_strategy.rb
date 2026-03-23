# Strategy pattern for rent calculation
# Allows different rent strategies without changing Game logic

class BaseRentStrategy
  def calculate(property, board)
    property.price
  end
end

class StandardRentStrategy < BaseRentStrategy
  def calculate(property, board)
    rent = property.price

    if owns_full_set?(property.owner, property.colour, board)
      rent *= 2
    end

    rent
  end

  private

  def owns_full_set?(player, colour, board)
    properties = board.properties_by_colour(colour)
    properties.all? { |p| p.owner == player }
  end
end