class RecipesController < ApplicationController
  def index
    @q = Recipe.ransack(params[:q])
    @recipes = @q.result.includes(:ingredients)
  end
end