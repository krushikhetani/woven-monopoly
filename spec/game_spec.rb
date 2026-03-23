require_relative "../game"

RSpec.describe Game do
  it "initializes players correctly" do
    game = Game.new("data/board.json", "data/rolls_1.json")
    expect(game).not_to be_nil
  end
end