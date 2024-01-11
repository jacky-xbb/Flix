class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_admin?

  def require_signin
    return if current_user

    session[:intended_url] = request.url
    redirect_to new_user_session_url, danger: 'Please sign in first!'
  end

  def current_user_admin?
    current_user&.admin?
  end

  def require_admin
    return if current_user_admin?

    redirect_to root_url, alert: 'Unauthorized access!'
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
