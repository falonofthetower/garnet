class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
      flash[:success] = "You may now begin"
    else
      redirect_to login_path
      flash[:danger] = "Your login isn't right--fix it!"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
    flash[:danger] = "You have been signed out!"
  end
end
