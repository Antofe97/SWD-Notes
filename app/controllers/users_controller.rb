class UsersController < ApplicationController
  add_flash_types :danger, :info, :warning, :success, :notice
  skip_before_action :authorized, only: [:new, :create]
  before_action :admin_permission, only: [:index]

  def new
    @user = User.new
  end

  def index
    @users = User.all

  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id || is_admin?

    else 
      redirect_to notes_path
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update(params.require(:user).permit(:email, :password, :admin))
      flash[:info] = "User's Profile sucesfully updated" 
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(params.require(:user).permit(:email, :password, :admin))
    session[:user_id] = @user.id
    flash[:success] = "Successfull Sing In!"
    redirect_to '/welcome'
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "The user was successfully destroyed. " 

    redirect_to users_path
  end
end
