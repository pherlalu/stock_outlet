class ProductsController < ApplicationController
  def index
    @products = Product.order(:name).page(params[:page]).per(12)
    @main_categories = Category.where(sub_category_id: nil)
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.categories.find { |cat| cat.sub_category_id.nil? }
    @sub_category = @product.categories.find { |cat| cat.sub_category_id.present? }
  end
end
