class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #include SessionsHelper

  before_filter :set_locale
  
  def set_locale
  # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
  if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
    session[:locale] = params[:locale]
  end

  I18n.locale = session[:locale] || I18n.default_locale
end

  def render404
    render :file => File.join(Rails.root, 'public', '404.html'), :status => 404, :layout => false
    return true
  end



  before_filter :configure_devise_params, if: :devise_controller?
  def configure_devise_params
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:name, :email, :password, :password_confirmation)
    end
  end

  

end
