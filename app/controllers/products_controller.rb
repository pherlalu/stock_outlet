class ProductsController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

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

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    session[:cart][id] ||= 0
    session[:cart][id] += quantity
    redirect_to cart_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id)
    redirect_to cart_path
  end

  def update_cart
    id = params[:id].to_i
    quantity = params[:quantity].to_i
    if quantity > 0
      session[:cart][id] = quantity
    else
      session[:cart].delete(id)
    end
    redirect_to cart_path
  end

  def cart
    @cart_items = load_cart_items
  end

  private

  def initialize_session
    session[:visit_count] ||= 0
    session[:cart] ||= {}
  end

  def load_cart
    @cart = session[:cart]
  end

  def load_cart_items
    session[:cart].map do |id, quantity|
      product = Product.find_by(id: id)
      if product
        { product: product, quantity: quantity }
      else
        session[:cart].delete(id)
        nil
      end
    end.compact
  end
end