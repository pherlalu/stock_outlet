class ProductsController < ApplicationController
  def index
    @on_sale_products = Product.on_sale.order(:name).limit(12)
    @new_products = Product.new_products.order(:name).limit(12)
    @recently_updated_products = Product.recently_updated.order(:name).limit(12)
    @all_products = Product.order(:name).page(params[:page]).per(12)
    @main_categories = Category.where(sub_category_id: nil)

    @filtered_products = case params[:filter]
                         when 'new'
                           @new_products
                         when 'recently_updated'
                           @recently_updated_products
                         else
                           @on_sale_products
                         end
  end

  def show
    @product = Product.find(params[:id])
    @category = @product.categories.find { |cat| cat.sub_category_id.nil? }
    @sub_category = @product.categories.find { |cat| cat.sub_category_id.present? }
  end
end
