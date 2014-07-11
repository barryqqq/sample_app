class Property < ActiveRecord::Base
	belongs_to :user
	#default_scope -> { order('created_at DESC') }
	has_many :photos #, as: :imageable 
 	has_many :collections, dependent: :destroy
	#has_many :users, :through => :collections

	#geocoded_by :address1

	# or with a method
	# full_address is a method which take some model's attributes to get a formatted address for example
  	geocoded_by :full_address 
	after_validation :geocode

	validate :end_after_start

	
	scope :category, -> (category) { where category: category }
	scope :gender, -> (gender) { where gender: gender }
	scope :pet, -> (pet) { where pet: pet }

	#scope :bed, -> (bed) { where bed: bed }

	def self.bed(bed)
		if bed.to_f < 3
			where bed: bed
		elsif bed.to_f == 3
			where ("bed >= 3") 
		end					
	end
	#scope :bath, -> (bath) { where bath: bath }
	def self.bath(bath)
		if bath.to_f < 2
			where bath: bath
		elsif bath.to_f == 2
			where ("bath >= 2") 
		end					
	end
	
	#scope :price, -> (price) { where("price <= ?", price) }

	def self.price(price)
		if price.to_f > 5 then
			 where("price <= ?", price)
		else
			where(nil)
		end	 

	end	

	def self.people(people)
		if people.to_f > 0 then
			 where("people <= ?", people)
		else
			where(nil)
		end	 

	end	

	def self.noBrokerFee (noBrokerFee) 

		if noBrokerFee then  # hasBrokerFee = 0 w/o broker fee
			where( hasBrokerFee: false)
		else
			where(nil)	
		end
	end

	def self.noDeposit (noDeposit) 

		if noDeposit then  # w/o Deposit
			where( hasDeposit: false)
		else
			where(nil)	
		end
	end	

	def self.noContract (noContract) 

		if noContract then  # w/o Contract
			where( hasContract: false)
		else
			where(nil)	
		end
	end		

	
		

	#scope :contract, -> (contract) { where contract: contract }
	#scope :broker_fee, -> (broker_fee) { where broker_fee: broker_fee }
	#scope :deposit, -> (deposit) { where deposit: deposit }



	scope :start_date, -> (start_date) { where("start_date >= ?", start_date) }
	#scope :utility, -> (utility) { where utility: utility }
	
	
	def self.max_price(category)
		if category == 2 then
			
		else
		end	
					
	end	



	 # the full_address method
	def full_address

  	# "#{address1}, #{city}, #{state}, #{zipcode}, #{country}"
  	if radio_addr == '0' then
			"#{address1}, #{city}, #{state}, #{zipcode}"
		elsif radio_addr == '1' then
			"#{b_address1} and #{b_address2}, #{b_city}, #{b_state}, #{b_zipcode}"
		end	
	end

	def all_address
    # "#{address1}, #{address2}, #{city}, #{state}, #{zipcode}"
		if radio_addr == '0' then
			"#{address1}, #{address2}, #{city}, #{state}, #{zipcode}"
		elsif radio_addr == '1' then
			"#{b_address1} and #{b_address2}, #{b_city}, #{b_state}, #{b_zipcode}"
		#	"#{b_address1}, #{b_address2}, #{b_state}"
		end	
	end

	private
		
		def end_after_start
  			return if end_date.blank? || start_date.blank?
 
  			if end_date < start_date
    			errors.add(:end_date, "must be after the start date") 
  			end 
 		end


end
