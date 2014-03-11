class UsersController < ApplicationController
  def new
    @user =User.find(params[:id])
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
