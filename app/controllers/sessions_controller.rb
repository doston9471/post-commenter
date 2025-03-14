class SessionsController < ApplicationController

  def new
  end

  def create
    Rails.logger.debug "Params received: #{params.inspect}"

    @user = User.find_by(email: params[:user][:email])

    if @user&.authenticate(params[:user][:password])  # This will check the hashed password
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in successfully"
    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out
    redirect_to login_path, notice: "You have successfully logged out!"
  end

  private

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
  end
end