class SessionsController < ApplicationController

  def create
    user = User.where(email: params[:user][:email]).first
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id.to_s
      redirect_to "/"
    else
      redirect_to '/signin'
    end
  end

  def new
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

end
