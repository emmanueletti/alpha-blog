class CategoriesController < ApplicationController
  before_action :find_category_by_param_id, only: %i[show edit update destroy]
  before_action :require_admin, except: %i[index show]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 2)
  end

  def show; end

  def new; end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:notice] = 'You have successfully created a category'
        format.html { redirect_to category_path(@category) }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  def category_params
    # params.require(:category).permit(:name)
    params.permit(:name)
  end

  def find_category_by_param_id
    @category = Category.find(params[:id])
  end

  def require_admin
    unless logged_in? && current_user.admin?
      flash[:alert] = 'only admins can perform that action'
      redirect_to categories_path
    end
  end
end
