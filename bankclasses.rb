class Bank
    def initialize(bank_name)
    	# Expects a string
    	@bank_name = bank_name
    	@bank_database = Hash.new
    end

    def set_bank_customer_funds(bank_customer, funds)
    	# Expects a BankCustomer object, and an integer or float
    	@bank_database[bank_customer] = funds
    end

    def get_bank_customer_funds(bank_customer)
    	# Expects a BankCustomer object
    	@bank_database[bank_customer]
    end

    def withdraw(customer, amount)
    	# Expects a BankCustomer object, and an integer or float

    	return false if amount > @bank_database[customer.customer_identity]

    	@bank_database[customer.customer_identity] = @bank_database[customer.customer_identity] - amount
    	true
    end

end

class CreditCard
	def initialize(customer_identity)
		# Expects a BankCustomer object
		@card_owner = customer_identity
	end

	def get_card_owner
		@card_owner
	end

end

class BankCustomer
	def initialize(customer_identity, initial_funds, bank_name)
		# Expects a string, integer or float, and a Bank object
		@customer_identity = customer_identity
		@bank_name = bank_name
		register_new_customer(initial_funds)
	end

	def customer_identity
		@customer_identity
	end

	def bank_name
		@bank_name
	end

	def card
		@card
	end

    def register_new_customer(funds)
    	bank_name.set_bank_customer_funds(@customer_identity, funds)
    end
    
    def register_new_credit_card
    	@card = CreditCard.new(self)
    end

    def deposit(amount)
    	bank_name.set_bank_customer_funds(@customer_identity, get_bank_customer_funds(@customer_identity) + amount)
    	puts "You deposited $#{amount} into your account, you now have $#{bank_customer[@customer_identity]}"
    end
end

class Store
	@products = { 'Cheesecake' => 12, 'Hair Dryer' => 52, 'Purple Object' => 600, 'Mask' => 25, 'Horn' => 125 }

	def self.display_products
		@products.each do | k, v |
			puts "#{k}: $#{v}"
        end
        nil
    end

    def self.purchase_item(credit_card, item)
    	# Expects a CreditCard object, and a valid item from the hash keys of @products
    	if @products[item].nil?
    		puts "No such item."
    		return nil
    	end

    	if credit_card.get_card_owner.bank_name.withdraw(credit_card.get_card_owner, @products[item])
    		puts "Transaction successful, have fun with your new #{item}!"
        else
        	puts "Card denied!"
    	end
    end
end

# Tests

bank = Bank.new('bank')
customer = BankCustomer.new('customer', 5000, bank)
