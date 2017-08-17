module RockPaperScissors
  PLAYS = ["rock", "paper", "scissors"]
  class Game
    def initialize
      player1 = Player.new
      player2 = Player.new
      play_game player1, player2
    end

    def play_game player1, player2
      player1.get_play
      player2.get_play
      result = Rule.tie_game?(player1.play, player2.play) ? Rule::TIE_GAME : Rule.find_winner(player1, player2)
      puts "Player 1 played #{player1.play}. Player 2 played #{player2.play}. " + result
    end

    class Rule
      P1WIN = "Player 1 Wins."
      P2WIN = "Player 2 Wins."
      TIE_GAME = "It was a tie."

      def self.tie_game? player1, player2
        true if player1 == player2
      end

      def self.find_winner player1, player2
        if player1.rock? and player2.scissors?
          P1WIN
        elsif player1.paper? and player2.rock?
          P1WIN
        elsif player1.scissors? and player2.paper?
          P1WIN
        else
          P2WIN
        end
      end
    end
  end

  class Player
    attr_reader :play
    def get_play
      @play = PLAYS.sample
    end

    def rock?
      @play == RockPaperScissors::PLAYS[0]
    end

    def paper?
      @play == RockPaperScissors::PLAYS[1]
    end

    def scissors?
      @play == RockPaperScissors::PLAYS[2]
    end
  end
end