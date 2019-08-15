class UsersController < ApplicationController
  #skip_before_action :verify_user_is_authenticated, only: [:new,:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
     session[:user_id] = @user.id
     session_login(@user)
     flash[:success] = "Welcome to your blog #{@user.username}"
     redirect_to articles_path
    else
     render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     flash[:success] = "Your account was updated successfully"
     redirect_to articles_path
    else
     render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
  @users = User.all
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
