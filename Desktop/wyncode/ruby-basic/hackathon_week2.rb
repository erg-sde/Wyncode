

def show_menu menu
  menu[:sections].each do |section|
    puts section[:name]
    section[:types].each do |type|
      puts "#{type[:name]} contains #{type[:description]} and it will cost $%.02f" % type[:price]
    end
  end
end

  # class Customer
  #   def get_action
  #     userwants = gets.chomp
  #     case userwants
  #     when "show menu"
  #       show_menu
  #     when "place order"
  #       take_order
  #     when "get the check"
  #       if @userorder != nil
  #       create_receipt
  #     else
  #       "Try again."
  #       get_action
  #     end
  #   end

  #   def show_menu menu
  #     menu.show_sections
  #     menu.show_dishes
  #   end

  #   def take_order
  #   end
  # end