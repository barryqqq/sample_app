class PropertiesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :new]
	

	def new

		#@property = Property.new	
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
		@properties = Property.paginate(page: params[:page])
		

	end	

	def show
		@property = Property.find(params[:id])
		@photos = Photo.where(property_id: params[:id])

		#for collection
		if signed_in?
			@c = Collection.where(user_id: current_user.id, property_id: params[:id])
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



	private

		def property_params
			params.require(:property).permit(:image, :price, :address1, :address2, :city, :state, :zipcode, :country, :radio_addr, :b_address1, :b_address2, :b_city, :b_state, :b_zipcode, :category, :bed, :bath, :price, :hasBrokerFee, :hasDeposit, :broker_fee, :deposit, :description, :contact_name, :contact_email, :contact_phone )

		end	


end

