class Human
  attr_reader :name, :birth, :hungry, :sleepy
  def initialize name, birth
    @name = name
    @birth = birth
    @hungry = true
    @sleepy = true
  end

  def hungry?
    @hungry
  end

  def sleepy?
    @sleepy
  end

  def have_breakfast
    @hungry = !@hungry
  end

  def take_a_nap
    @sleepy = !@sleepy
    @hungry = !@hungry
  end
end