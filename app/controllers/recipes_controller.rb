class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @recipe = Recipe.all.order("created_at DESC")
  end
  
  def show
    
  end
  
  def new
    @recipe = current_user.recipes.build
  end
  
  def create
    @recipe = current_user.recipes.build(recipe_params)
    if @recipe.save
      flash[:success] = "Recipe was created successfully"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Recipe was updated successfully"
      redirect_to @recipe
    else
      render 'edit'
    end
  end
  
  def destroy
    @recipe.destroy
    redirect_to recipes_path, notice: "Recipe was deleted successfully"
  end
  
  private
  
  def recipe_params
    params.require(:recipe).permit(:title, :description, :image, ingredients_attributes: [:id, :name, :_destroy], directions_attributes: [:id, :step, :_destroy])
  end
  
  def find_recipe
    @recipe = Recipe.find(params[:id])
  end
end
