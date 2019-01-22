class CommentsController < ApplicationController
  before_action :get_product, only: [ :new, :create, :edit, :update, :destroy]
  before_action :check_uesr, only: [ :edit, :destroy]
  before_action :get_category
  # before_action :set_user, except: [:new, :create]

  def new
    @categories = Category.all
    @comment = @product.comments.build
    set_user
    #@comment.comment_by = current_user.email
  end

  def create
    @comment = @product.comments.build(comment_params)
    set_user
    if @comment.save
      # redirect_to product_url(@product)
    else
      #render 'new'
    end
  end

  def edit
    @comment = @product.comments.find(params[:id])
  end

  def update
    @comment = @product.comments.find(params[:id])
    @comment_id = @comment.id
    if @comment.update(comment_params)

      #redirect_to product_url(@product) 
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:product_id])
    @comment = @product.comments.find(params[:id])
    @comment_id = @comment.id
    if @comment.destroy
    end
    #redirect_to product_url(@product)
  end
  
  private
    def comment_params
      params.require(:comment).permit(:your_comment, :comment_by)
      end

    def get_product
      @product = Product.find(params[:product_id])  
    end
    def check_uesr
      @comment = Comment.find(params[:id])
      unless (current_user.id == @comment.user_id || current_user.role == "Admin")
       #or  unless current_user.email == @comment.comment_by || current_user.role == "Admin")    
        redirect_to product_path(@product), notice: 'Not your comment, So can\'t Edit or Delete'
      end
    end
    def set_user
      @comment.user_id = current_user.id
    end

    def get_category
      @categories = Category.all
    end
end
