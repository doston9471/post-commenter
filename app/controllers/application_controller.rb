class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def require_login
    redirect_to login_path, alert: "You must be logged in to access this page." if current_user.nil?
  end
end
