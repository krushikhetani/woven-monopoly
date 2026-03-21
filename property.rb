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

  def owned?
    !@owner.nil?
  end
end