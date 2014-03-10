class UsersController < ApplicationController
  def new

  end

  def create
  	@user = User.new(params[:user])
  	if @user.save 
  		#handle successful save
  	else
  		render 'new'
  	end		
  end	
end
