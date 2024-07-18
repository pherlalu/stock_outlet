class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_main_categories

  private

  def set_main_categories
    @main_categories = Category.where(sub_category_id: nil)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :province_id, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :province_id, :address])
  end
end
