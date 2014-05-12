class SearchesController < ApplicationController
	helper_method :sort_column, :sort_direction

	def new

		#@projects = Search.search(params[:search])
	end	

	def search
		
		#@property = (search_params)

		#redirect_to "/properties"
	end	


	def show
		@property = Property.find(params[:id])

		if signed_in?
      		@c = Collection.where(user_id: current_user.id, property_id: params[:id])
    	end

		# respond property object and photos url	
		respond_to do |format|
		#	format.html { redirect_to @c }	
			#format.js { render :json => @c.to_json()}
			format.json { render :json => @property.to_json(:methods => [:all_address ], :include => {:photos => {:only => :id, :methods => [:image_url_medium] } }) }
			
		end
	end	

	def index
		if params[:location].present?
      		#@properties = Property.near(params[:location])
      		@properties = Property.order(sort_column + ' ' + sort_direction).near(params[:location]).paginate(page: params[:page], per_page: '8')
      		# return search query to page 
      		@search_query = params[:location]
    	else
    		#request.ip
    		location_info = request.location
    		@properties = Property.order(sort_column + ' ' + sort_direction).near([location_info.latitude, location_info.longitude]).paginate(page: params[:page])
      		#@properties = Property.all
      		
    	end
		
		#@property = Property.new
		
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
  			#marker.title   "i'm the title"
		end
			

	end	


	private
		

		def search_params
			params.require(:property).permit(:image, :price, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone )

		end	

		# default created_at DESC
		def sort_column
			#params[:sort] || 'created_at'
			Property.column_names.include?(params[:sort]) ? params[:sort] : 'created_at'
		end	

		def sort_direction
			params[:direction] || 'desc'
			%w[asc desc].include?(params[:direction]) ? params[:direction] : 'desc'
		end

end
