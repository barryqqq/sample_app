class PropertiesController < ApplicationController
	before_filter :authenticate_user!, only: [:create, :destroy, :new]

	before_filter :admin_user, only: [:index]
	before_filter :post_user, only: [:new]


	#before_action :signed_in_user, only: [:create, :destroy, :new]
	helper_method :sort_column, :sort_direction	
	before_action :ensure_permission, only: [:edit, :update]



	def new

		@property = Property.new	
		#@photo = Photo.new
	end

	def create
		@property = current_user.properties.build(property_params)
		
		#@photo = Photo.find( params[:photo][:image_id])  #find photo by parameter 

		#if params[:photo][:image_id] = 50
			 
			if @property.save

				params[:photo].each do |photo_id|
					@photo = Photo.find(photo_id)  #find photo by parameter	

					@photo.update_attribute(:property_id, @property.id) #update property_id to the photo
						
					
				end


				flash[:success] = "You just posted successfully!"
				redirect_to property_path(@property)
				
			else 
				render 'static_page/home'
				
			
			end		
		#end	
	end

	def index

		# only list the user's properties
		#@properties = current_user.properties.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: '10')		

		#for all properties
		@properties = Property.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: '10')		

	end	


	def show
		@property = Property.find(params[:id])
		@photos = Photo.where(property_id: params[:id])

		#for collections
		if signed_in?
			@c = Collection.where(user_id: current_user.id, property_id: params[:id])
		end

	end

	def edit
		# determin if this property is belongs to current user
		@property = Property.find(params[:id])
		@photos = Photo.where(property_id: params[:id] )
	end	

	def update
		@property = Property.find(params[:id])
	    if @property.update_attributes(property_params)

	    	params[:photo].each do |photo_id|
				@photo = Photo.find(photo_id)  #find photo by parameter	

				@photo.update_attribute(:property_id, @property.id) #update property_id to the photo
						
					
			end
	    	# successful update
	      	flash[:success] = "Profile Updated"
	      	redirect_to @property
	    else
	    	flash[:warning] = "Oooops! Something wrong"	
	      	render 'edit'
	    end   
	end	
		

	def destroy
		if current_user.id == Property.find(params[:id]).user_id

			Property.find(params[:id]).destroy
	    	flash[:success] = "Property deleted."
	    else
	    	flash[:danger] = "Property cant be deleted !!"	
	    end
	    	
    	#redirect_to properties_url
    	redirect_to(:back)
	end 


	# add a property to user's collection
	def add_collection

		c = Collection.create(user_id: current_user.id, property_id: params[:id])
		
		if c.save
			render :nothing => true
			
		end	
				
	end	

	# remove a property from user's collections
	def del_collection

		c = Collection.where(user_id: current_user.id, property_id: params[:id])
		c.first.destroy
		render :nothing => true

	end

	# check if the property has been in user's collection
	#def collect
	#	@c = Collection.where(user_id: current_user.id, property_id: params[:id])
	#	respond_to do |format|
	#		format.json { render :json => @c.to_json()}
	#	end	
	#end	



	def facebook_share
		if current_user.access_token == nil
			flash[:warning] = "please connect to your facebook account first"
			redirect_to user_path
		else

			@graph = Koala::Facebook::API.new(current_user.access_token)
		    #profile = @graph.get_object("me")
		    #friends = @graph.get_connections("me", "friends")
		    #@graph.put_wall_post("hey, test test test!!")
		    #@graph.put_connections("me", "feed", :message => "I am TESTINGNNGNGg on a page wall!")
		    #@graph.put_like(734053186606656)

		    #@graph.put_connections(534606226653467, "feed", :message => "I am TESTINGNNGNGg on a page wall!")
		    
		    #@graph.put_wall_post("I am TESTINGNNGNGg on a page wall!!", "534606226653467")
		    property = Property.find(params[:id])
		   

		    # post on user's wall
		    @graph.put_wall_post("#{property.description}".truncate(50), 
		      { :name => "#{property.full_address}", 
		        :link => "localhost:3000/properties/#{property.id}",
		        :caption => "",
		        :description => render_type(property.category),
		        :picture   => "#{property.photos.first.image_url_medium}"
		        #:picture => "http://#{a}.s3.amazonaws.com/photos/images/000/000/175/medium/1399872102.jpg?321321312321"
		      },
		       "me"
		    )


=begin
		    # post on group
		    @graph.put_connections("me", "feed", {
		      :message   => property.description,
		      #:caption => render_type(property.category),
		      #:description => property.description, 
		      :link => "localhost:3000/properties/#{property.id}",
		      :picture   => property.photos.first.image_url_medium
		      
		     
		    })
=end	    


=begin
		    # post on group
		    @graph.put_connections(250003681855910, "feed", {
		      :message   => "#{property.description}".truncate(20),
		      :picture   => "#{property.photos.first.image_url_medium}",
		      :link => "localhost:3000/properties/#{property.id}"

		      #:link      => "https://www.around-u.org/properties/#{property.id}"
		    })
=end
		 
		   

			flash[:success] = " Shared this post on facebook successfully. " 
		    redirect_to :back
		end
		
	end	


	    



	private

		def property_params
			params.require(:property).permit(:image, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone, :isPublic, :ip, :hasContract, :hasElectricity, :hasHeat, :hasInternet, :contract, :gender, :people, :pet, :count, :start_date, :end_date )

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
				

		#only poster can see his post
		def ensure_permission
			property = Property.find(params[:id])
			user = User.find(property.user_id)
			if current_user != user then
				flash[:warning] = "You can not pass."
				redirect_to root_url
			end	
		end


		def admin_user
			if (!current_user.try(:admin?))
				flash[:warning] = "You can not pass."
				redirect_to root_url
			end	
		end	

		def post_user
			if (!current_user.can_post?)
				flash[:warning] = "You can not pass."
				redirect_to root_url
			end	
		end	

		def render_type(type)
			if type.to_f == 0 then 
		      "Rent" 
		      #raw("<span class='label label-default'>Rent</span>") 
		    elsif type.to_f == 1
		      "Shared Apt."
		    elsif type.to_f == 2
		      "Sublease" 
		    end           
		 end 
			

end

