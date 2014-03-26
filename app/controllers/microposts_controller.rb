class MicropostsController < ApplicationController
	before_action :signed_in_user

	def create
		@micropost = current_user.microposts.build(micropost_params)
		
		if @micropost.save
			flash[:success] = "Created a new micropost !"
			redirect_to :back
		else
			render 'static_page/home'
		end		
	end	

	def destroy
	end	


	private

		def micropost_params
			params.require(:micropost).permit(:content)
		end	
end


	