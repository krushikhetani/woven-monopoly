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

  def move(steps, board_size)
    previous_position = @position
    @position = (@position + steps) % board_size
    passed_go = (@position < previous_position)
    passed_go
  end
def buy_property(property)
  return if property.price.nil?   

  @money -= property.price
  property.owner = self
  @properties << property
end

  def pay(amount, receiver = nil)
  if @money < amount
    @money = 0   
    return false
  end

  @money -= amount
  receiver.money += amount if receiver
  true
end

  def bankrupt?
    @money < 0
  end
end