class SearchesController < ApplicationController

	def new
		#@projects = Search.search(params[:search])
	end	

	def search
		
		#@property = (search_params)

		#redirect_to "/properties"


	end	

	def index
		if params[:location].present?
      		@properties = Property.near(params[:location])
    	else
    		#request.ip
    		@properties = Property.near(request.ip)
      		#@properties = Property.all
    	end
		@property = Property.new
		#@properties = Search.search(params[:property])
	
	end	


	private
		

		def search_params
			params.require(:property).permit(:image, :price, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone )

		end	


end
