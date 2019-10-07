class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user!
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    if !@current_user
      throw "Not logged in"
    end
  end
end
