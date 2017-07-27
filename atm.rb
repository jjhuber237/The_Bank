require_relative 'the_bank_classes'

@customers = []
@accounts = []

def welcome_screen
  @current_customer = ""
  puts
  puts "Welcome to the Bank To End All Banks"
  puts "Please choose one of the following options:"
  puts "-------------------------------------------"
  puts "1. Customer Sign in"
  puts "2. New Customer Registration"

  choice = gets.chomp.to_i

  case choice
  when 1
    sign_in
  when 2
    sign_up("","")
  end
end

def sign_in
  puts "What is your name?"
  name = gets.chomp
  puts "What is your location?"
  location = gets.chomp.to_i
  if @customers.empty?
    puts "No customer found with that information."
    puts "Would you like to sign up with the information you just provided? Y or N"

    reply = gets.chomp.downcase

      if reply = "y"
        sign_up(name, location)
      else
        welcome_screen
      end

  end

  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && location == customer.location
      @current_customer = customer
      customer_exists = true
    end
  end

if customer_exists
  account_menu
else
  puts
  puts "No customer found with that information."
  puts "1. Try Again."
  puts "2. Sign Up."
  choice = gets.chomp.to_i
end

  case choice
  when 1
    sign_in
  when 2
    sign_up(name, location)
  end
end

def sign_up(name, location)
  if name == "" && location == ""
    puts "What's your name?"
    name = gets.chomp
    puts "What's your location?"
    location = gets.chomp
  end
  @current_customer = Customer.new(name,location)
  @customers.push(@current_customer)
  puts "Registration Successful! Yay!"
  account_menu
end

def account_menu
  puts
  puts "Account Menu"
  puts "------------"
  puts "1. Create Account"
  puts "2. Review Account"
  puts "3. Sign Out"
  choice = gets.chomp.to_i

  case choice
  when 1
    create_account
  when 2
    review_account
  when 3
    puts "Thank you for banking with us"
    welcome_screen
  else
    puts "invalid selection"
    account_menu
  end
end

def create_account
  puts "How much are you going to deposit?"
  print "$"
  amount = gets.chomp.to_f
  puts "What type of account will you be opening?"
  type = gets.chomp

  new_account = Account.new(@current_customer, type, (@accounts.length + 1), amount)
  @accounts.push(new_account)

  puts "Account Successfully Created"
  account_menu


end

def review_account

  @current_account = ""
  puts "What type of account would you like to review?"
  type = gets.chomp.downcase

  account_exists = false
  @accounts.each do |account|
    if @current_customer == account.customer && type == account.account_type
        @current_account = account
        account_exists = true
    end
  end


  if account_exists
    current_account_actions
  else
    puts "No account type found."
    account_menu
  end
end

def current_account_actions

  puts "Choose from the following:"
  puts "--------------------------"
  puts "1. Check balance"
  puts "2. Make a deposit"
  puts "3. Make a withdrawal"
  puts "4. Back to account menu"
  puts "5. Sign out"

  choice = gets.chomp.to_i

  case choice
  when 1
    puts "Your balance is $#{'%0.2f' %(@current_account.balance)}"
    account_menu
  when 2
    @current_account.deposit
    account_menu
  when 3
    @current_account.withdrawal
    account_menu
  when 4
    account_menu
  when 5
    puts "Thank you for coming in today."
    welcome_screen
  end
end

welcome_screen
