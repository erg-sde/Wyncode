class Deck
  attr_reader :cards
  def initialize
    self.build_deck
  end

  def build_deck
    @cards = Array.new()
    Card::VALUES.each do |value|
      Card::SUITS.each do |suit|
        card = Card.new(value = value, suit = suit)
        @cards << card
      end
    end
  end

  def draw
    @cards.shuffle
    @cards.pop
  end
end
