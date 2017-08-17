=begin
Command Line questions:
1 => cd path_goes_here
)
2 => ls
3 => touch filename.txt 
4 => mkdir name_your_dir
5 => ls -a
6 => ruby filename.rb
7 => echo 'hello' >> filename.txt
8 => Press Control+C
9 => a path is an address for locating a file within a directory hierarchy

Ruby Syntax 
1. a method is an "action" or "message" to/on an object (the receiver)
2. an exclamation mark indicates that a method changes an object in place, 
rather than returning a new object and leaving the receiver unchanged.
3. a question mark method will return true or false
4. an argument is a parameter that a method requires upon calling in order to execute properly 
(except procs (no ArgumentError) BUT not lambdas (throws ArgumentError))
5. "something".class returns "something"'s class, in this case String. Because everything is an object, 
all data types in ruby correspond to a Class.

Ruby Data Types
1. Fixnum is an integer that can be represented in a single unit of OS memory, 
for 64 bit architecture this is an 8 bit number I believe.
2. Fixnum allows you to call any of the operators for boolean or bitwise operations,
math operations, question mark methods such as .odd? and .even? and introspective methods
like .respond_to? and .method()
3. A Hash is similar to Python's Dictionary object, and allows the developer to set "keys"/:keys that correspond to 
"values" rather than fixed identifiers such as the indices of Arrays. 
=end

wish_you_were_here = Hash.new
wish_you_were_here[:artist] = "Pink Floyd"
wish_you_were_here[:track_list] = Array.new
wish_you_were_here[:track_list] << {:name => "Shine on You Crazy Diamond (Parts I - V)", :length => "13:32"}
wish_you_were_here[:track_list] << {:name => "Welcome to the Machine", :length => "7:32"}
wish_you_were_here[:track_list] << {:name => "Have a Cigar", :length => "5:24"}
wish_you_were_here[:track_list] << {:name => "Wish You Were Here", :length => "5:40"}
wish_you_were_here[:track_list] << {:name => "Shine on You Crazy Diamond (Parts VI - IX)", :length => "12:29"}

puts wish_you_were_here[:artist]
puts wish_you_were_here[:track_list][3][:name]
puts wish_you_were_here[:track_list][2][:length]

wyncode_addy = Hash.new
wyncode_addy[:street] = "425 N Andrews Blvd"
wyncode_addy[:suite_no] = 995
wyncode_addy[:city_state] = "Ft. Lauderdale, Florida"
wyncode_addy[:zip_code] = 33321

puts %(Wyncode's address is #{wyncode_addy[:street]}, #{wyncode_addy[:suite_no]}
in #{wyncode_addy[:city_state]}, #{wyncode_addy[:zip_code]})

my_arr = Array.new(5, "words")
# p my_arr

cardinals = ["north", "east", "south", "west"]

i = 0
while i < 3 do
  puts cardinals[i]
  i += 1
end

my_arr.each do |i|
  puts "cri#{i}"
end

for j in 2..10
  if j.even?
    puts j
  end
end

def fizzbuzzing
  for i in 1..25
    str = ""
    str << "Fizz" if i % 3 == 0
    str << "Buzz" if i % 5 == 0
    unless str == ""
      puts str
    else
      puts i
    end
  end
end

class ProfitCalc
  def initialize
    puts "What did you invest initially"
    @principal = gets.chomp.to_f
    puts "What is the annual percentage rate?"
    @apr = gets.chomp.to_f
    puts "For what period of time are we calculating? (years please)"
    @period = gets.chomp.to_f
  self.get_profit
  end

  def profit_calc principal = @principal, apr = @apr / 100, period = @period
    @profit = principal * ((1 + apr) ** period)
  end

  def get_profit 
    self.profit_calc
    puts "Your profit for $#{@principal} at #{@apr} for #{@period} years is: %.02f" % @profit
  end
end

def rock_paper_loop
  srand(number = Random.new_seed)
  i = 0
  begin
    plays = ["rock", "paper", "scissors"]
    @player1 = plays[rand(0..2)]
    @player2 = plays[rand(0..2)]
    puts "Player 1 plays #{@player1}. Player 2 plays #{@player2}"
    unless @player1 == @player2
      if @player1 == "rock"
        if @player2 == "scissors"
          puts "Player 1 wins."
        else
          puts "Player 2 wins."
        end
      elsif @player1 == "paper"
        if @player2 == "scissors"
          puts "Player 2 wins."
        else
          puts "Player 1 wins."
        end
      else
        if @player2 == "rock"
          puts "Player 2 wins."
        else
          puts "Player 1 wins."
        end
      end
    else
      puts "It was a tie."
    end
  end while i == 0
end

def letter_guesser
  srand(number = Random.new_seed)
  @letters = Array.new
  for i in "a".."z"
    @letters << i
  end
  @targetstr = ""
  3.times do |i|
    i = rand(0..25)
    @targetstr << @letters[i]
  end
  p @targetstr
  @guesscount = 0
  @correct = ""
  while @guesscount < 6
    puts "Take a shot. 3 random letters."
    @guess = gets.chomp.chars
    @guess.each do |i|
      if @targetstr.include?(i)
        @correct << i
      end
    end
    if @correct.chars.sort == @targetstr.chars.sort
      puts "Well done. #{@guesscount + 1} guesses to guess #{@targetstr}"
      return nil
    end
    @guesscount += 1
  end
end