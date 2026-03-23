# Represents a player in the game
# Handles movement, money, and property ownership

class Player
  attr_reader :name
  attr_accessor :position, :money, :properties

  START_MONEY = 16

  def initialize(name)
    @name = name
    @position = 0
    @money = START_MONEY
    @properties = []
  end

  # Move player around the board
  def move(steps, board_size)
    previous_position = @position
    @position = (@position + steps) % board_size

    # Return true if passed GO
    @position < previous_position
  end

  # Purchase a property
  def buy_property(property)
    return if property.price.nil?

    @money -= property.price
    property.owner = self
    @properties << property
  end

  # Pay rent to another player
  def pay(amount, receiver = nil)
    # Prevent negative balance
    if @money < amount
      @money = 0
      return false
    end

    @money -= amount
    receiver.money += amount if receiver
    true
  end

  # Check if player is bankrupt
  def bankrupt?
    @money <= 0
  end
end