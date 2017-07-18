class SessionsController < ApplicationController

  def new
  end

  def sign_in
  end

  def create
    if params[:username].present? && params[:username] != ""
      session[:user_id] = @user.id
      redirect_to home_path
    else
      redirect_to '/sessions/new'
    end
  end

  def home
  end

  def show
    @user = current_user.username
  end

  def edit
  end

  def index
  end

  def destroy
    if session[:username].present?
      session.delete :username
    end
    redirect to sign_in_path
  end

end
