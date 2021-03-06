class UsersController < ApplicationController
  before_action :require_login, only: [:show, :index]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:message] = "Welcome!"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    @activities = @user.activities.alpha
  end

  def index
    @user = User.find_by(id: params[:id])
  end

private
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
