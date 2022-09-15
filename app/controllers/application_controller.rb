class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully"
    root_path
  end

  def after_sign_in_path_for(resource)
    if current_user
      flash[:notice] = "Sign in successfully"
	    user_path(resource)
    else
	    flash[:notice] = "Sign up successfully"
	    user_path(resource)
    end 
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
    end
end
