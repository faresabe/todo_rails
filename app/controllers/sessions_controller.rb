class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    begin
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        session[:login_time] = Time.current
        redirect_to todos_path, notice: "Logged in successfully."
      else
        flash.now[:alert] = "Invalid email or password."
        render :new, status: :unprocessable_entity
      end
    rescue BCrypt::Errors::InvalidHash
      # Log the error for debugging purposes
      Rails.logger.error "Invalid password hash for user #{user&.email}"
      flash.now[:alert] = "There was a problem with your account. Please contact support."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by(email: params[:email])
    user.update(last_seen: Time.current) if user
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully."
  end
end