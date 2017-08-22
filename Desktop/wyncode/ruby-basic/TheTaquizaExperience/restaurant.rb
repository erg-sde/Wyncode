class Restaurant
  SALES_TAX = 0.07
  attr_accessor :menu, :name
  def initialize menu, name
    restaurant_menu = Menu.new menu
    @menu = restaurant_menu
    @name = name
  end

  def greeting
    puts "Welcome to #{@name}"
  end

  def show_menu
    @menu.show
  end

  def print_receipt customer
    puts "Thanks for eating at #{@name}. Here's your receipt:\n"
    subtotal = 0
    customer.purchase.each do |name|
      @menu[:sections].each do |section|
        section[:types].each do |type|
          if name == type[:name]
            price = type[:price]
            puts "#{name}: %.02f" % price
            subtotal += price
          end
        end
      end
    end
    tax = subtotal * SALES_TAX
    total = subtotal + tax
    puts "Subtotal: %.02f" % subtotal
    puts "Tax: %.02f" % tax
    puts "Total: %.02f" % total
    Restaurant.recommended_tip total, [15, 18, 20]
    customer.receipt
  end

  def self.recommended_tip total, pct_array
    rec_tips = []
    pct_array.each do |percent|
      tip = total * percent/100
      rec_tips << tip + total
    end
    puts "Recommended Tip:\n"
    rec_tips.each_index do |i|
      puts "\t#{pct_array[i]}\%\: #{rec_tips[i]}"
    end
    rec_tips
  end

  class Menu
    attr_reader :restaurant_menu
    def initialize restaurant_menu
      @restaurant_menu = restaurant_menu
    end

    def show
      # iterate over the sections
      @restaurant_menu[:sections].each do |section|
        puts section[:name]
        # iterate over the types
        section[:types].each do |type|
          name = type[:name]
          description = type[:description]
          price = type[:price]
          puts name, "\tDescription: #{description}"
          puts "\tPrice: $#{price}", ""
        end
      end
    end

    def [] key
      self[:"#{key}"]
    end
  end
end