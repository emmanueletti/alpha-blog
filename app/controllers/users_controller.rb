class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "welcome to the Alpha blog #{@user.username}, you have successfully created an account"
    else
      render 'new'
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
