class Person
  attr_accessor :hair_color, :name
  def initialize name, hair_color
    @name = name
    @hair_color = hair_color
  end
  def sing
    %(Life is too short so love the one you got
    cause you might get run over or you might get shot.")
  end  
end

# sandy = Person.new "Sandy", "brown"
# p sandy
# sandy.hair_color = "blonde"
# puts sandy.sing

class Wyncoder < Person
  def code
    "I am coding!"
  end

  def to_s
    "Greetings. I'm a Wyncoder named #{@name}. Pleased to meet you."
  end
  def inspect
    "Well now that you've gotten nice and close, you can see my #{@hair_color} hair."
  end
end

walter = Wyncoder.new "walter", "yellowish-purple"
puts walter.sing
puts walter.code
puts walter
p walter