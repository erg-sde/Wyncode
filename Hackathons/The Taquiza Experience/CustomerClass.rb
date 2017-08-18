module In_Out
  def run customer, restaurant
    customer.purchase = Array.new
    puts restaurant.greeting
    until customer.wants == "get the check"
      puts "How can we help you today?"
      customer.wants = gets.chomp.downcase
      case customer.wants
      when "show menu"
        restaurant.show_menu
      when "place order"
        customer.purchase = place_order(restaurant.menu)
      when "get the check"
        unless customer.purchase.nil?
          customer.receipt = restaurant.print_receipt customer
        else
          puts "You need to order first!"
          redo
        end
      else
        puts "I didn't catch that."
      end
    end
  end
end

class Customer
  include In_Out
  attr_accessor :purchase, :wants, :receipt
  def initialize restaurant
    @wants = run(self, restaurant)
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
