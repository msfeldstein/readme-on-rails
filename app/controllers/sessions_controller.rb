class SessionsController < ApplicationController
  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    session[:user_id] = @user.id
    redirect_to @user
  end

  def destroy
    session.delete(:user_id)
    if current_user
      session.delete(:user_id)
      flash[:success] = "Logged Out"
    end
    redirect_to root_path
  end
 
  protected
 
  def auth_hash
    request.env['omniauth.auth']
  end
end