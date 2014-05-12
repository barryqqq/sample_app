class PhotosController < ApplicationController
	def new
		@photo = Photo.new
	end	


	#POST /photos
	def create 

		@photo = Photo.create( photo_params)

		respond_to do |format|
			if @photo.save
				#render :template => "/properties/new", :layout => false
			#	redirect_to @photo
			#else
			#	render photo_path	
			#end	
	
				#format.html { @photo, notice: "photo created successfully !!"  }
#, flash[:success] = "photo created successfully !!"

				format.json {
				#	data = {
				#		id: @photo.id,
						#thumb: view_context.image_tag(@photo.photo.url(thumb))
				#	}
					#render json: @photo
					render :json => @photo, :methods => :image_url_medium

				}	
				#render photo_path
				#format.html { redirect_to root_url}
				#format.html { render action: 'index' }
				#{}format.json {render json: @photo.errors, status: :unprocessable_entity}
			end	
	
		end			


	end	

	
	def destroy
		@photo = Photo.find(params[:id])
		respond_to do |format|
			if @photo.destroy
			end
			format.json {
					render :json => @photo

				}	
		
		end		

	end	


	private
  
    	def photo_params
    		params.permit( :image)

      		#params.require(:photo).permit(:image)
      		#params[:photo].permit(:image) 
    	end 
			

end
