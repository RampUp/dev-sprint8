class CreditCard
	def initialize(bank, cust)
		@bank = bank
		@cust = cust
	end

	def bank()
		@bank
	end
	def cust()
		@cust
	end
end


class BankCustomer
	def initialize(name, balance)
		@name = name
		@balance = balance
		@credit_card
	end

	def balance()
		@balance
	end

	def deduct_funds(amount)
		@balance -= amount
	end
	def add_funds(amount)
		@balance += amount
	end
	def assign_card(card)
		@credit_card = card
	end

	def credit_card()
		@credit_card
	end
	def get_name()
		@name
	end
end


class Bank
	def initialize(name)
		@BankName = name
		@customers = Hash.new
	end

	def withdraw(name, amount)
		if @customers[name].balance > amount
			@customers[name].deduct_funds(amount)
			puts "withdraw success. new balance #{@customers[name].balance}"
			return true
		else
			puts "insufficient funds"
			return false
		end
	end

	def deposite(amount)
		@customers[name].add_funds(amount)
		puts "Added #{amount} to your balance. New balance is #{@balance}"
	end

	def enroll_BankCustomer(name, balance)
		if @customers.has_key?(name)
			puts "customer already exists"
		else
			
			cust = BankCustomer.new(name, balance)
			card = CreditCard.new(self, cust)
			cust.assign_card(card)

			@customers[name] = cust
			puts "added customer!"
			cust
		end
	end

	def name()
		@BankName
	end
end


class Store
	def initialize(name)
		@name = name
	end
	def sell_item(cost, card)
		customer=card.cust
		name = customer.get_name
		card.bank.withdraw(name, cost)
	end
end

b = Bank.new("BofA")
anthony = b.enroll_BankCustomer('Anthony', 5000)
b.enroll_BankCustomer('john', 2000)
b.withdraw('Anthony', 2000)
b.withdraw('john', 3000)
anthony_card = anthony.credit_card
s = Store.new('store')

s.sell_item(100, anthony_card)
