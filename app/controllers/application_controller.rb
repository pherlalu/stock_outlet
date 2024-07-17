class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :province_id, customer_address_attributes: [:address]])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :province_id, customer_address_attributes: [:address]])
  end
end
