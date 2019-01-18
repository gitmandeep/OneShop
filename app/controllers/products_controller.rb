class ProductsController < ApplicationController
  before_action :check_privileges!, only: [:index, :new, :create, :edit, :destroy]
  def index
    @products = Product.all.page params[:page]
  end

  def show
    @categories = Category.all
    @product = Product.find(params[:id])
    @comments = @product.comments
    @comment = @product.comments.build
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
   else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    redirect_to products_path
  end

  def userview 
    @categories = Category.all
    @products = Product.all.page params[:page]
  end

  def by_category
    @categories = Category.all
    @category  = Category.find(params[:category_id])
    @product   = @category.products
  end

  def redirect_after_sign_in
    if current_user.role == "Admin"
      redirect_to  products_url
    else
      redirect_to products_userview_url
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :price, :picture, :category_id)
  end

  def check_privileges!
    unless current_user.role == "Admin"
      redirect_to "/", notice: 'You dont have enough permissions to be here' 
    end
  end
end