class UserMailer < ActionMailer::Base
  default from: "no-reply@around-u.org"

  def welcome_email(user)
  	@user = user
  	@url = 'https://boiling-escarpment-8908.herokuapp.com/signin'
  	mail to: @user.email, subject: "Welcome to join us !"

  end

  def change_password_email(user, password)
  	@user = user
  	@url = 'https://boiling-escarpment-8908.herokuapp.com/login'
  	@password = password
  	mail to: @user.email, subject: "Your new password has been setted !"

  end

  def contact_email(name, phone, email, message, property_id)
      @sender_name = name
      @sender_phone = phone
      @sender_email = email
      @message = message
      @property = Property.find(property_id)
      mail to: "iamcooc@gmail.com", subject: "someone want you"

  end  

  	
end
