module RockPaperScissors
  class Game
    # make two players so they can battle each other
    def initialize
      player1 = Player.new
      player2 = Player.new
      play_game player1, player2
    end

    def play_game player1, player2
      result = Rule.tie_game?(player1.play, player2.play) ? Rule.tie_game : Rule.player1_win(player1.play, player2.play)
      puts "Player 1 played #{player1.play}. Player 2 played #{player2.play}. " + result
    end
  end

  attr_reader :play
  class Player
    Plays = ["rock", "paper", "scissors"]
    # get each player's choice for the round
    def initialize
      @play = get_play
    end

    def get_play
      return Plays[rand(0..2)]
    end
  end

  # check the rules and return the game's result
  class Rule
    Plays = ["rock", "paper", "scissors"]
    P1Win = "Player 1 wins."

    def self.tie_game? player1, player2
      if player1 == player2
        true
      else
        false
      end
    end

    def self.tie_game
      "It was a tie."
    end

    def self.player1_win player1, player2
      if player1 == Plays[0] and player2 != Plays[1]
        P1Win
      elsif player1 == Plays[1] and player2 != Plays[2]
        P1Win
      elsif player2 != Plays[0]
        P1Win
      else
        "Player 2 wins."
      end
    end

  end
end

include RockPaperScissors
# loop do
#   Game.new
# end