# Represents a property on the board

class Property
  attr_reader :name, :price, :colour, :type
  attr_accessor :owner

  def initialize(data)
    @name = data["name"]
    @price = data["price"]
    @colour = data["colour"]
    @type = data["type"]
    @owner = nil
  end

  # Check if property is owned
  def owned?
    !@owner.nil?
  end
end