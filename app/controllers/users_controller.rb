class UsersController < ApplicationController
  before_action :authenticate_user!, only: [ :edit, :update, :index, :show, :destroy]
  before_filter :admin_user, only: [ :index, :destroy]
  before_filter :correct_user, only: [ :show, :edit, :update]

=begin
  before_action :sign_in_user, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :signed_in_user, only: [:edit, :update, :index]
  before_action :admin_user, only: :destroy


  def new
    @user = User.new
  end


  def create
  	@user = User.new(user_params)
  	
    if @user.save 
      sign_in @user
      #send welcome email
      UserMailer.welcome_email(@user).deliver
      flash[:success] = "Welcome to join us !!"
		  #handle successful save
      redirect_to @user

  	else
      flash[:danger] = "field can not blank."
  		render 'new'
  	end	


  end

=end

  def index
    #@users = User.all
    @users = User.paginate(page: params[:page])
  end
    
  def show
    @user = User.find(params[:id])
    #@microposts = @user.microposts.paginate(page: params[:page])
    @properties = @user.properties.paginate(page: params[:property_page], :per_page => 8).order('created_at DESC')
    @collections = @user.properties.joins(:collections).paginate(page: params[:collection_page], :per_page => 2).order('created_at DESC')

    #if signed_in?
      #@post = current_user.microposts.build
    #end
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

  def admin
    @user = User.find(params[:id])
    if current_user.admin?
      if @user.admin?
        @user.update_attribute :admin, 0
      else
         @user.update_attribute :admin, 1
      end   
    end  
    redirect_to action: "index"

  end 

  def post
    @user = User.find(params[:id])
    if current_user.admin?
      if @user.can_post?
        @user.update_attribute :can_post, 0
      else
         @user.update_attribute :can_post, 1
      end   
    end  
    redirect_to action: "index"

  end 

  def avatar
    @user = User.find(params[:id])
    @user.update_attributes(avatar_param)
    redirect_to action: "show"
  end  
   

  private
    # :password, :password_confirmation,:avatar
    def user_params
      params.require(:user).permit(:name, :first_name, :last_name, :email, :phone, :birthday, :gender, :language, :education, :work, :location)
    end 

    def avatar_param
      params.require(:user).permit(:avatar)    
    end  


    def sign_in_user
      #redirect_to signin_url, warning: "Please sign in" else signed_in?  
      unless signed_in?
        flash[:warning] = "Please sign in "
        redirect_to signin_url
      end  
    end 

    def correct_user
      @user = User.find(params[:id])
      redirect_to (root_url) unless current_user == @user || current_user.admin == 1

    end

    def admin_user
      redirect_to (root_url) unless current_user.admin == 1
    end 

    
   
  

end
