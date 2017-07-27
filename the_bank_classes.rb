class Customer

  attr_accessor :name, :location

  def initialize(name, location)
    @name = name
    @location = location
  end
end

class Account

  attr_accessor :customer, :account_type
  attr_reader :account_number, :balance

  def initialize(customer, account_type, account_number, balance)
    @customer = customer
    @account_type = account_type
    @account_number = account_number
    @balance = balance
  end

  def deposit
    puts "How much would you like to deposit?"
    print "$"
    amount = gets.chomp.to_f
    @balance += amount
    puts "You're new balance is $#{'%0.2f' %(@balance)}"
  end

  def withdrawal
    puts "How much would you like to deposit?"
    print "$"
    amount = gets.chomp.to_f
    if @balance < amount
      @balance -= (amount + 25)
    else
      @balance -= amount
    end
    puts "You're new balance is $#{'%0.2f' %(@balance)}"
  end
end
