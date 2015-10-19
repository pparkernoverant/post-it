class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = "The category was created."
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private 

  def category_params
    params.require(:category).permit(:name)
  end
end
