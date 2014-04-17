class UserMailer < ActionMailer::Base
  default from: "no-reply@around-u.org"

  def welcome_email(user)
  	@user = user
  	@url = 'https://boiling-escarpment-8908.herokuapp.com/signin'
  	mail to: @user.email, subject: "Welcome to join us !"

  end
  	
end
