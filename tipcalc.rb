class TipCalculator
  def user
    # Define user, party params
    puts "What's your name, please?"
    @name = gets.chomp.capitalize!
    puts "How many in your party?"
    @party = gets.chomp.to_i
  end

  def get_tip bill = gets.chomp.to_f, tip = gets.chomp.to_f
    # This is where the magic happens
    @tip = tip./(100)
    @bill = bill
    @total = (@tip * @bill) + @bill
    puts "Your total bill with tip included is: %.02f" % @total
  end

  def split_bill bill = @total, party = @party || nil, name = @name
    # Split bill evenly by party size
    total = bill/party
    puts "%.02f" % total + " is #{name}\'s share of the bill!"
  end

  def initialize
    # The whole shebang
    self.user
    puts "How much was your bill? What percentage would you like to tip?"
    self.get_tip
    unless @party <= 0
      self.split_bill 
    end
  end
end

tipcalc = TipCalculator.new