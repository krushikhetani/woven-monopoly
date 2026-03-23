require_relative "../player"

RSpec.describe Player do
  it "does not allow negative balance" do
    player = Player.new("Test")
    result = player.pay(20)
    expect(result).to be false
    expect(player.money).to eq(0)
  end
end