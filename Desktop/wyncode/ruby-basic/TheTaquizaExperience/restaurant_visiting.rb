module RestaurantVisiting
  def run customer, restaurant
    menu = restaurant.menu
    restaurant.greeting
    until customer.wants == "get the check"
      puts "How can we help you today?"
      customer.wants = gets.chomp.downcase
      case customer.wants
      when "show menu"
        restaurant.show_menu
      when "place order"
        customer.purchase = place_order(menu)
      when "get the check"
        unless customer.purchase.size == 0
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