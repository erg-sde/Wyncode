module GuessThatLetter
  attr_accessor :guess, :guesscount, :right
  class Player
    Welcome = "Welcome to Guess That Letter... There are actually 3 different letters." 
    def initialize
      puts Welcome
      @guesscount = 0
      @right = []
    end
  end

  class Game
    Letters = ("a".."z").to_a
    def initialize
      target = get_target
      player = Player.new
      start_game player, target
    end

    def start_game player, target
      begin
        player.guess = get_guess player
        check_guess player, target
      end while player.right.sort != target and player.guesscount < 5
      if player.right.sort == target
        puts win player, target
      else
        puts lose target
      end
    end

    def get_guess player
      prompt = "Give me your best guess. You have #{5 - player.guesscount} tries#{" remaining" if player.guesscount > 0}."
      puts prompt
      player.guesscount += 1
      gets.chomp.chars
    end

    def check_guess player, target
      player.guess.each do |i|
        if target.include? i
          player.right << i unless player.right.include? i
        end
      end
    end

    def win player, target
      "Congratulations. You got it in #{player.guesscount} guess#{player.guesscount > 1 ? "es" : nil}! Your target was #{target.join(", ")}"
    end

    def lose target
      "Sorry friend. You lose. Your target was #{target}."
    end

    def get_target
      target = []
      3.times do |i|
        i = rand(0..25)
        (target.include? Letters[i]) ? redo : target << Letters[i]
      end
      target.sort
    end
  end
end

include GuessThatLetter
Game.new