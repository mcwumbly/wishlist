class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_current_user

  def get_current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id])
    end
  end

end
