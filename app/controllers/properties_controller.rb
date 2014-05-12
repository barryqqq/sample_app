class PropertiesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new]
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
				redirect_to properties_url
				
			else 
				render 'static_page/home'
				
			
			end		
		#end	
	end

	def index

		# only list the user's properties
		@properties = current_user.properties.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: '10')		

		#for all properties
		#@properties = Property.order(sort_column + ' ' + sort_direction).paginate(page: params[:page], per_page: '10')		

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
	    	# successful update
	      	flash[:success] = "Profile Updated"
	      	redirect_to @user
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
	    	
    	redirect_to properties_url
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



	private

		def property_params
			params.require(:property).permit( :end_date, :image, :price, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone, :isPublic, :ip, :hasContract, :contract, :gender, :people, :pet, :count, :start_date )

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
			if !current_user?(user) then
				redirect_to root_url
			end	
		end
			

end

