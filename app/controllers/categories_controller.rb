class CategoriesController < ApplicationController
  def create
    @category = Category.new(category_params)
    if @category.save
      render json: { id: @category.id, name: @category.description }, status: :created
    else
      render json: { errors: @category.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def category_params
    params.require(:category).parmit(:description)
  end
end
