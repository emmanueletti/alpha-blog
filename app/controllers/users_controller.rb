class UsersController < ApplicationController
  before_action :find_user_by_param_id, only: %i[show edit update destroy]

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

  def edit; end

  def update
    result = @user.update(user_params)

    if result
      flash[:notice] = 'User was edited successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user_by_param_id
    @user = User.find(params[:id])
  end
end
