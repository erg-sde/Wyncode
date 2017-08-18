class Restaurant
  SALES_TAX = 0.07
  attr_reader :menu, :name
  def initialize name, menu
    @name = name
    @menu = menu
  end
​
  def greeting
    puts "Welcome to #{@name}"
  end
​
  def show_menu(menu = @menu)
    # iterate over the sections
    menu[:sections].each do |section|
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
​
  def print_receipt customer
    puts "Thanks for eating at #{@name}. Here's your receipt:\n"
    customer.receipt = Hash.new
    customer.purchase.each do |name, price|
      @menu[:sections].each do |section|
        section[:types].each do |type|
          dishname = type[:name]
          price = type[:price]
          if  dishname.downcase == name
            customer.receipt[:"#{name}"] = price
          end
        end
      end
    end
    subtotal = 0
    customer.receipt.each_pair do |name, price|
      puts "#{name}: #{price}"
      subtotal += price
    end
    tax = subtotal * SALES_TAX
    total = subtotal + tax
    puts "Subtotal: #{subtotal}"
    puts "Tax: %.02f" % tax
    puts "Total: %.02f" % total
    puts "Recommended Tip:\n\t15\%\: #{Restaurant.tipcalc(total, 0.15)}"
    puts "\t18\%: #{Restaurant.tipcalc(total, 0.18)}"
    puts "\t20\%: #{Restaurant.tipcalc(total, 0.2)}"
    customer.receipt
  end
​
  def self.tipcalc total, percent
    total + (total * percent).round(2)
  end
end
​
module TaquizaMenu
    MENU = 
  {sections:
  [
    {
      name: "Tacos", types:[
        {
          name: "Al Pastor",
          description: "pork, achiote, pineapple",
          price: 3.50
        },
        {
          name:"Chorizo",
          description: "pork, paprika, cumin, garlic",
          price: 3.50
        },
        {
          name: "Barbacoa",
          description:"beef, cumin, pasilla negra",
          price: 3.50
        },
        {
          name: "Pollo",
          description:"chicken, scallion, cilantro",
          price: 3.50
        },
        {
          name: "Huitlacoche",
          description:"corn 'truffle', corn, scallion",
          price: 3.50
        },
        {
          name: "Carnitas",
          description: "pork, orange, cinnamon",
          price:3.50
        },
        {
          name: "Adada",
          description:"steak,citrus,chile de arbol",
          price:3.50
        },
        {
          name: "Lengua",
          description:"beef tongue, cerveza victoria",
          price:3.50
        },
        {
          name: "Camaron",
          description:"shrimp, red 'mole', slaw",
          price: 3.50
        },
        {
          name: "Rajas",
          description:"poblano, onion, crema, cotija",
          price:3.50
        },
        {
          name: "Chapulines",
          description:"grasshoppers, avocado, tajin",
          price:3.50
        }
      ]
    },
    {
      name: "Sides / Antojitos", types:[
        {
          name:"Totopos",
          description:"hand torn blue masa chips",
          price:5
        },
        {
          name: "Quinoa",
          description:"jicama, corn, scallion, chile, nopal dressing",
          price:6.50
        },
        {
          name:"Elote",
          description:"charred corn, cilantro-jalapeno crema, cotija",
          price:5.00
        }
      ]
    },
    {
      name: "Beer/Cerveza", types:[
        {
          name:"Corona Extra",
          description:"",
          price:7.00
        },
        {
          name:"Pacifico",
          description:"",
          price:6.00
        },
        {
          name:"Corona Light",
          description:"",
          price:6.00
        },
        {
          name:"Tecate",
          description:"",
          price:5.00
        },
        {
          name:"Negra Modelo",
          description:"",
          price:6.00
        },
        {
          name:"Victoria",
          description:"",
          price:6.00
        },
        {
          name:"Rotating Craft Selection",
          description:"",
          price:8.00
        }
      ]
    },
    {
      name:"Breakfast", types:[
        {
          name:"Huevos a la Mexicana",
          description: "scrambled eggs, pico,frijoles, crema, tortillas",
          price: 5
        },
        {
          name: "Quesadillas de Epazote",
          description:"queso chihuahua, cotija,epazote",
          price: 5
        },
        {
          name:"Tostada De Aquacate",
          description:"avocado, eggs, frijoles, cabbage, cotija",
          price: 6
        },
        {
          name:"Chilaquiles",
          description:"crispy masa, pollo, salsa roja, eggs, crema",
          price: 6
        },
        {
          name:"Tortilla De Aguacate",
          description:"avocado, queso chihuahua, cotija, frijoles",
          price: 6
        }
      ]
    },
    {
      name: "Coffee & Tea", types:[
        {
          name:"espresso",
          description:"shot 3 | cortado 4 | latte 5",
          price: 3
        },
        {
          name:"La Endulzada",
          description:"espresso, condensed milk, ice, shaken",
          price: 5
        }
      ]
    }
  ]
  }
end
​
​
class Taquiza < Restaurant
  include TaquizaMenu
  def initialize name = "Taquiza", menu = TaquizaMenu::MENU
    super
  end
end
​
module In_Out
  def run customer, restaurant
    puts restaurant.greeting
    until customer.wants == "get the check"
      puts "How can we help you today?"
      customer.wants = gets.chomp.downcase
      case customer.wants
      when "show menu"
        restaurant.show_menu
      when "place order"
        customer.purchase = place_order(customer, restaurant.menu)
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
​
  def place_order(customer, menu)
    puts "Start placing your order..."
    order = nil
    customer.purchase = []
    until order == "done ordering"
      order = gets.chomp
      # confirm the order is in the menu
      menu[:sections].each do |section|
        section[:types].each do |type|
          name = type[:name].downcase
          if order == name
            customer.purchase << name
          end
        end
      end
    end
    customer.purchase
  end
end
​
class Customer
  include In_Out
  attr_accessor :purchase, :wants, :receipt
  def initialize restaurant
    @wants = run self, restaurant
  end
end