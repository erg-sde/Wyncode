# spec/bank_account_spec.rb
require './oop_bank'
include OopBank

describe BankAccount do
  context "has a balance" do
    let :account do
      account = BankAccount.new(500, "Sarah")
    end

    it "is created with an opening balance and the name of the client" do
      expect(account).to be_a BankAccount
    end

    it "can report its balance" do
      expect(account.balance).to eq 500
    end
  end

  context "making a deposit" do
    let :account do
      account = BankAccount.new 500, "Sarah"
      account.deposit(500)
      account
    end
    it "balance is increased" do
      expect(account.balance).to eq 1000
    end
    it "raise error on depositing negative" do
      expect{ account.deposit -100 }.to raise_error TransactionError
    end
  end

  context "making a withdrawal" do
    let :account do
      account = BankAccount.new 500, "Sarah"
      account.withdraw 500
      account
    end
    it "balance is decreased" do
      expect(account.balance).to eq 0
    end
    it "fee if balance goes below 0" do
      account.withdraw(100)
      expect(account.balance).to eq(-135)
    end
  end

  context "transferring funds" do
    let(:account) do
      account = BankAccount.new(500, "Sarah")
    end

    let(:other_account) do
      other_account = BankAccount.new(1000, "Todd")
    end

    before :each do
      account.transfer(501, other_account)
    end

    it "account balance is decreased" do
      expect(account.balance).to eq(-36)
    end

    it "other account balance is increased" do
      expect(other_account.balance).to eq(1501)
    end

    it "fee if balance goes below 0" do
      expect(account.balance).to eq(-36)
    end
  end

  context "minimum balance" do
    it "raises an error if opening balance is too low" do
      expect { BankAccount.new 199, "Sarah" }.to raise_error ArgumentError
    end

    it "does NOT raise an error if opening balance is over minimum balance" do
      expect { BankAccount.new 201, "Sarah" }.not_to raise_error
    end
    it "allows the bank owner to change the minimum balance" do
      BankAccount.minimum_opening_deposit = 100
      expect(BankAccount.minimum_opening_deposit).to eq 100
    end
    it "does NOT allow new accounts with balance under new minimum_opening_deposit" do
      BankAccount.minimum_opening_deposit = 100
      expect{ BankAccount.new 99, "Sarah" }.to raise_error ArgumentError
    end
  end

  context "logging transactions" do
    let :account do
      account = BankAccount.new(500, "Sarah")
    end

    it "logs new account creation" do
      expect(BankAccount.transaction_log_print).to include({:Sarah=>{:opening_balance=>500}})
    end

    it "logs deposits to accounts" do
      account.deposit 500
      expect(BankAccount.transaction_log_print).to include({:Sarah=>{:deposit=>500}})
    end

    it "logs withdrawals from accounts" do
      account.withdraw 200
      expect(BankAccount.transaction_log_print).to include({:Sarah=>{:withdraw=>200}})
    end

    it "logs transfers between accounts" do
      other_account = BankAccount.new 500, "Todd"
      account.transfer(100, other_account)
      expect(BankAccount.transaction_log_print).to include({{:Sarah=>"Todd"}=>{:transfer=>100}})
    end
  end
end