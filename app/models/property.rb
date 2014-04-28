class Property < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') }
	#has_many :photos, as: :imageable

	has_many :users, :through => :collections

	#geocoded_by :address1

	# or with a method
	# full_address is a method which take some model's attributes to get a formatted address for example
  	geocoded_by :full_address 


	after_validation :geocode

	 # the full_address method
  	def full_address
    	"#{address1}, #{zipcode}, #{city}, #{country}"
  	end

end
