class CategoriesController < ApplicationController

  def index
    @categories = Category.all
  end

  def list_cat
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    # @category_id = @category.id
    if @category.save
      #redirect_to categories_path
    else
      render 'new'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @cat_id = @category.id
    @category.destroy
    #redirect_to categories_path
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end
end 