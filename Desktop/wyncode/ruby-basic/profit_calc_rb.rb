module ProfitCalculator
  class Calculator
    attr_reader :principal, :apr, :period
    
    def initialize(principal, apr, period)
        @principal = principal
        @apr = apr
        @period = period
    end

    def get_profit
      @principal * ((1 + @apr) ** @period)
    end 
  end 
end 

module ProfitCalculator
  class IO
    def run
      principal = ask_question "What did you invest initially"
      apr = ask_question "What is the annual percentage rate?"
      period = ask_question "For what period of time are we calculating? (years please)"
      new_calc = ProfitCalculator::Calculator.new(principal, apr, period)   
      calc_reponse new_calc
    end
      
    def ask_question prompt 
      puts prompt
      response = gets.chomp.to_f
    end

    def calc_reponse profit_calc
      puts "Your profit for $#{profit_calc.principal} at #{profit_calc.apr} for #{profit_calc.period} years is: %.02f" % profit_calc.get_profit
    end 
  end 
end 

newPC = ProfitCalculator::IO.new
newPC.run