class SearchController < ApplicationController

	def create
		
		@property = (property_params)

		redirect_to "/properties"

	end	

	def new
	end	

end
