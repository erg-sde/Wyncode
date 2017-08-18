class Restaurant
  SALES_TAX = 0.07
  attr_reader :menu, :name
  def initialize menu, name
    restaurant_menu = Menu.new menu
    @menu = restaurant_menu.restaurant_menu
    @name = name
  end

  def greeting
    puts "Welcome to #{@name}"
  end

  def show_menu
    # iterate over the sections
    @menu[:sections].each do |section|
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

  def print_receipt customer
    puts "Thanks for eating at #{@name}. Here's your receipt:\n"
    subtotal = 0
    customer.receipt = Hash.new
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
    puts "Recommended Tip:\n\t15\%\: #{Restaurant.tipcalc(total, 0.15)}"
    puts "\t18\%: #{Restaurant.tipcalc(total, 0.18)}"
    puts "\t20\%: #{Restaurant.tipcalc(total, 0.2)}"
    customer.receipt
  end

  def self.tipcalc total, percent
    total + (total * percent).round(2)
  end

  class Menu < Hash
    attr_accessor :restaurant_menu
    def initialize restaurant_menu
      @restaurant_menu = restaurant_menu
    end
  end
end