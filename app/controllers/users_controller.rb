class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    user = User.new
    p = params[:user]
    user.email = p[:email]
    user.username = p[:username]
    user.gender = p[:gender]
    user.birthday = p[:birthday]
    user.password = p[:password]
    user.password_confirmation = p[:password_confirmation]
    user.save!
    session[:user_id] = user.id.to_s
    redirect_to "/"
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = @current_user
  end

  def update
    p = params[:user]
    user = User.find(params[:id])
    if user != @current_user
      redirect_to "/"
    else
      user.email = p[:email]
      user.username = p[:username]
      user.gender = p[:gender]
      user.birthday = p[:birthday]
      user.save!
      redirect_to "/"
    end
  end

end
