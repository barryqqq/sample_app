class ContactFormsController < ApplicationController
	def new
		@property = Property.find(params[:id])
	  	@photo = Photo.where(property_id: params[:id]).first


	  	respond_to do |format|
	  		format.js
	    	format.json{ render :property => @property, :photo => @photo }
	  	end

	end

  	def create
  		if UserMailer.contact_email(params[:name], params[:phone], params[:email], params[:message], params[:property_id]).deliver
  			flash[:success] = "We've send the mail!!"
  		else
  			flash[:danger] = "something wrong!!"
  		end
  		
  		redirect_to(:back)
  	end


	


	private
		
		def form_params
			params.permit(:name, :email, :phone, :message, :property_id)
		end	
end
