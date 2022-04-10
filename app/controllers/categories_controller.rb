class CategoriesController < ApplicationController
  def index; end

  def show; end

  def new; end

  def create
    @category = Category.new(category_params)
    respond_to do |format|
      if @category.save
        flash[:notice] = 'You have successfully created a category'
        format.html { redirect_to category_path(@category) }
      else
        render 'new'
      end
    end
  end

  private

  def category_params
    # params.require(:category).permit(:name)
    params.permit(:name)
  end
end
