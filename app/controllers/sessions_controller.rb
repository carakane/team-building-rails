class SessionsController < ApplicationController

  def new
    if current_user
      redirect_to categories_path
    end
  end

  def create
    if auth_hash = request.env["omniauth.auth"]
      user = User.find_or_create_by_omniauth(auth_hash)
      session[:user_id] = user.id
      redirect_to categories_path
    else
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        flash[:message] = "Welcome back!"
        redirect_to categories_path
      else
        redirect_to '/sessions/new'
      end
    end
  end

  def home
  end

  def show
    @user = current_user.username
  end

  def destroy
    reset_session
    redirect_to sign_in_path
  end
end
