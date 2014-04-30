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
    		location_info = request.location
    		@properties = Property.near([location_info.latitude, location_info.longitude])
      		#@properties = Property.all
    	end
		@property = Property.new
		#@properties = Search.search(params[:property])
	
		#gmaps
		@hash = Gmaps4rails.build_markers(@properties) do |property, marker|
			marker.lat property.latitude
			marker.lng property.longitude
			marker.json({ :id => property.id })
			#marker.infowindow "info"
			marker.infowindow render_to_string(:partial => "/searches/info_window", :locals => { :property => property}).gsub(/\n/, '').gsub(/"/, '\"')
			#marker.picture({
            #      :url    => "https://around_you_and_me.s3.amazonaws.com/users/avatars/000/000/110/mini/1538815_1497519833804771_9000860252536223052_n.jpg",
            #      :width  => "32",
            #      :height => "32"
            #})
  			marker.title   "i'm the title"
		end
			

	end	


	private
		

		def search_params
			params.require(:property).permit(:image, :price, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone )

		end	


end
