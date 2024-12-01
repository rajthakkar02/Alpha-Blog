class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in!"
      redirect_to user
    else
      flash.now[:alert] = "The email or password you entered is incorrect. Please check and try again."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out!"
    redirect_to root_path
  end
end
