class UsersController < ApplicationController


  before_action :sign_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :admin_user, only: :destroy


  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
    
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])

    if signed_in?
      @post = current_user.microposts.build 
    end
  end

  def new
    @user = User.new
  end


  def create
  	@user = User.new(user_params)
  	if @user.save 
      sign_in @user
      flash[:success] = "Welcome to join us !!"
  		#handle successful save
      redirect_to @user
  	else
  		render 'new'
  	end		
  end	

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # successful update
      flash[:success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end   
  end 

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    redirect_to users_url

  end  

  def post 
    
  end   



  private
  
    def user_params
      params.require(:user).permit(:avatar, :name, :email, :password, :password_confirmation)
    end 


    #before filters

=begin
    def signed_in_user
      unless signed_in?
        store_location
        flash[:warning] = "Please sign in "
        redirect_to signin_url
      end
    end      
=end


    def sign_in_user
      #redirect_to signin_url, warning: "Please sign in" else signed_in?  
      unless signed_in?
        flash[:warning] = "Please sign in "
        redirect_to signin_url
      end  
    end 

    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user?(@user)

    end

    def admin_user
      redirect_to (root_url) unless current_user.admin == 1
        
      
    end  
      


end