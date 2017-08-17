module Restaurant
  class Menu
    def show_dishes
    end

    def show_sections
      self[:sections].each_index do |i|
        puts self[:sections][i][:name]
      end
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