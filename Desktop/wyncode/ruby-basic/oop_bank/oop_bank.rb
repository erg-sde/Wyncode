# require "oop_bank/version"

module OopBank
  class BankAccount
    attr_accessor :name, :balance
    @@minimum_opening_deposit = 200
    @@overdraft_fee = 35
    @@transaction_log = []

    # create accounts for our 6 customers
    def initialize opening_balance, name
      @name = name
      @balance = opening_balance
      if opening_balance < @@minimum_opening_deposit
        raise ArgumentError
      end
      # log account creation
      @@transaction_log << {:"#{@name}"=>{:opening_balance => @balance}}
    end

    # customers want to deposit money in their accounts
    def deposit deposit
      unless deposit < 0
        @balance += deposit.to_i 
        # log transactions
        BankAccount.log_transaction @name, deposit, "deposit"
      else 
        raise TransactionError
      end
    end

    # customers want to withdraw money too
    def withdraw withdrawal
      unless withdrawal < 0
        @balance -= withdrawal.to_i
        self.overdraft
        BankAccount.log_transaction @name, withdrawal, "withdraw"
      else
        raise TransactionError
      end
    end

    # these 6 people send each other money sometimes too
    def transfer transfer, other_account
      unless transfer < 0
        @balance -= transfer
        self.overdraft
        other_account.balance += transfer
        BankAccount.log_transfer @name, transfer, other_account
      else
        raise TransactionError
      end
    end

    def self.minimum_opening_deposit= new_minimum_opening_deposit
      @@minimum_opening_deposit = new_minimum_opening_deposit
    end

    def self.minimum_opening_deposit
      @@minimum_opening_deposit
    end

    def overdraft
      if @balance < 0
        @balance -= @@overdraft_fee
      end 
    end

    def self.log_transaction name, amount, type
      @@transaction_log << { :"#{name}" => { :"#{type}" => amount } }
    end

    def self.log_transfer name, amount, other_account
      @@transaction_log << { {:"#{name}" => "#{other_account.name}"} => { :transfer => amount } }
    end

    def self.transaction_log_print
      @@transaction_log
    end

    rescue ArgumentError
      puts "Minimum opening deposit = $#{@@minimum_opening_deposit}"
    rescue TransactionError
      puts "Negative transactions not allowed"
  end

  class TransactionError < ArgumentError
  end
end
