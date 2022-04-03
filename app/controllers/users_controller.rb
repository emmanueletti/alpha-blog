class UsersController < ApplicationController
  before_action :find_user_by_param_id, only: %i[show edit update destroy]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        flash[:notice] = "welcome to the Alpha blog #{@user.username}, you have successfully created an account"
        # the code to "sign a user in" is to fill the RAILS "session" object with the user_id
        session[:user_id] = @user.id
        format.html { redirect_to user_path(@user) }
      else
        render 'new'
      end
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

  def show; end

  def index
    @users = User.all
    @users = User.paginate(page: params[:page], per_page: 2)
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user_by_param_id
    @user = User.find(params[:id])
  end
end
