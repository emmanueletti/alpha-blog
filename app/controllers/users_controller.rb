class UsersController < ApplicationController
  before_action :find_user_by_param_id, only: %i[show edit update destroy]
  before_action :require_user_logged_in, except: %i[show index create new] # defined in the parent ApplicationController
  before_action :require_access_to_profile, only: %i[edit destroy update]

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
        format.html { render :new, status: :unprocessable_entity }
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

  def destroy
    @user.destroy
    # reset session to auto log out user in Rails
    session[:user_id] = nil if @user == current_user # this allows for admin accounts to delete other
    # peoples accounts and not get auto logged out after the delete
    flash[:notice] = 'Account and all associated articles successfully deleted'
    redirect_to root_path
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def find_user_by_param_id
    @user = User.find(params[:id])
  end

  def require_access_to_profile
    # check if @article was created by the current user or user is an admin
    has_access = @user == current_user || user.admin?
    return if has_access

    # if not created by the current user redirect
    flash[:alert] = 'You can only edit or delete your own profile'
    redirect_to users_path
  end
end
