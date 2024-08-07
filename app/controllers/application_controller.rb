class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_main_categories
  before_action :set_current_cart

  helper_method :current_cart_path

  private

  def set_main_categories
    @main_categories = Category.where(sub_category_id: nil)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :province_id, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :province_id, :address])
  end

  def set_current_cart
    if session[:current_cart_id]
      @current_cart = Cart.find_by(secret_id: session[:current_cart_id])
    else
      @current_cart = Cart.create
      session[:current_cart_id] = @current_cart.secret_id
    end
  end

  def current_cart_path
    cart_path(@current_cart)
  end
end
