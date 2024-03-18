class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?

def after_sign_up_path_for(resource)
    case resource
    when User
      user_path(current_user.id)
    else
      root_path
    end
end

def after_sign_in_path_for(resource)
   case resource
    when Admin
    root_path
    when User
      user_path(current_user.id)
    else
      root_path
   end
end

def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
end


  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end


end
