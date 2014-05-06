class Property < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	has_many :photos #, as: :imageable

 
 	has_many :collections, dependent: :destroy
	#has_many :users, :through => :collections

	#geocoded_by :address1

	# or with a method
	# full_address is a method which take some model's attributes to get a formatted address for example
  geocoded_by :full_address 


	after_validation :geocode

	 # the full_address method
	def full_address

  	#{}"#{address1}, #{city}, #{state}, #{zipcode}, #{country}"
  	if radio_addr == '0' then
			"#{address1}, #{city}, #{state}, #{zipcode}"
		elsif radio_addr == '1' then
			"#{b_address1}, #{b_address2}, #{b_city}, #{b_state}, #{b_zipcode}"
		end	
	end

	def all_address
    "#{address1}, #{address2}, #{city}, #{state}, #{zipcode}"
		if radio_addr == '0' then
			"#{address1}, #{address2}, #{city}, #{state}, #{zipcode}"
		elsif radio_addr == '1' then
			"#{b_address1}, #{b_address2}, #{b_city}, #{b_state}, #{b_zipcode}"
		end	
	end



end
