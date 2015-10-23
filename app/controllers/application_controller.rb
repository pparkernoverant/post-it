class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in?, :current_is_creator?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def current_is_creator?(obj)
    logged_in? && (obj.user == current_user || current_user.admin?)
  end

  def require_user
    access_denied unless logged_in?
  end

  def require_creator(obj)
    access_denied unless current_is_creator?(obj)
  end

  def require_admin
    access_denied unless logged_in? && current_user.admin?
  end

  def access_denied
    flash[:error] = 'You do not have permission to do that.'
    redirect_to root_path
  end
end
