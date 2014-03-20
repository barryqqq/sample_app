class SessionsController < ApplicationController


	#create a new session
	def create 		
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			#sign the user in and redirect to this user's show page.
			sign_in user
			#redirect_to user
			redirect_back_or user
		else
			flash.now[:danger] = 'invalid email/password combination'
			render 'new'
		end		

	end

	# page for a new session (sign in)
	def new
	end

	#delete a session
	def destroy
		sign_out
		redirect_to root_url
	end	

end
