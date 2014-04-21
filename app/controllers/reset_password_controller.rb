class ResetPasswordController < ApplicationController
	def new
		@user = User.new
	end
	
	def create

		#create a tempoarey pw and send it to the user's email account
	  	
	    user = User.find_by(user_params)

	    tempPassword = random_string(8)

	    user.update_attribute(:password, tempPassword)
	    if UserMailer.change_password_email(user, tempPassword).deliver

	    	flash[:success] = "Email sent with new password."
	    	redirect_to signin_path
	    end	

  	end 

  	
  	private
  		def user_params
      		params.require(:user).permit(:email)
    	end 

    	def random_string(len)
			#generate a random password consisting of strings and digits
			chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a 
			password = ""
			1.upto(len) { |i| password << chars[rand(chars.size-1)]}
			return password
  		end	

end
