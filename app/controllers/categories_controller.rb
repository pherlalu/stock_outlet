class CategoriesController < ApplicationController
  before_action :set_main_categories, only: [:index, :show]
  before_action :find_category, only: [:show]
  before_action :find_sub_category, only: [:show], if: -> { params[:sub_category_name].present? }

  def index
    # @main_categories is already set by set_main_categories
  end

  def show
    if @category.nil?
      redirect_to categories_path, alert: 'Category not found'
      return
    end

    if params[:sub_category_name].present? && @sub_category.nil?
      redirect_to category_path(@category), alert: 'Subcategory not found'
      return
    end

    @products = if @sub_category
                  @sub_category.products
                else
                  @category.products
                end
  end

  private

  def set_main_categories
    @main_categories = Category.where(sub_category_id: nil)
  end

  def find_category
    @category = Category.find_by(name: params[:name])
  end

  def find_sub_category
    @sub_category = @category.sub_categories.find_by(name: params[:sub_category_name]) if @category
  end
end
