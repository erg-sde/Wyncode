require './restaurant'

class Taquiza < Restaurant
  def initialize menu
    super(menu, "Taquiza")
  end
end