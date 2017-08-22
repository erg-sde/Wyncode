class Card
  attr_reader :value, :suit
  VALUES = (1..13).to_a
  SUITS = ["hearts", "spades", "clubs", "diamonds"]

  def initialize value, suit
    if value.to_i < 14 and value.to_i > 0
      @value = value.to_i
    else
      raise ArgumentError
    end
    if suit.respond_to? :to_s
      if SUITS.include? suit
        @suit  = suit
      else
        raise ArgumentError
      end
    else
      raise ArgumentError
    end
  end

  def face
    case @value
    when 2..10
      @value
    when 1
      "Ace"
    when 11
      "Jack"
    when 12
      "Q"
    when 13
      "King"
    end
  end

  def to_s
    "#{self.face} of #{self.suit.capitalize}"
  end
end
