require './restaurant_visiting'

class Customer
  include RestaurantVisiting
  attr_accessor :purchase, :wants, :receipt
  def initialize restaurant
    @wants = run(self, restaurant)
    @purchase = Array.new
  end

  def place_order(menu)
    puts "Start placing your order..."
    order = nil
    until order == "done ordering"
      order = gets.chomp
      # confirm the order is in the menu
      menu[:sections].each do |section|
        section[:types].each do |type|
          name = type[:name].downcase
          if order == name 
            @purchase << order
          end
        end
      end
    end
    @purchase
  end
end