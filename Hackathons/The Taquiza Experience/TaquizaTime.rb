require './RestaurantClass.rb'

class Taquiza < Restaurant
  def initialize menu
    super(menu, "Taquiza")
  end
end