class SessionsController < ApplicationController

  skip_before_action :authorized, only: [:new, :create, :welcome]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/notes'
    else
      flash[:danger] = "Invalid Email or Password!"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully Logged Out!"
    redirect_to "/"
  end

  def login
  end

  def welcome
  end

  def page_requires_login
  end
end
