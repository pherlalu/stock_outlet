class CartsController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_product, only: [:create, :destroy]
  before_action :set_province, only: [:show, :checkout, :stripe_session]
  before_action :set_current_customer

  def create
    @cart_item = @current_cart.cart_items.find_by(product_id: @product.id)
    if @cart_item
      @cart_item.increment!(:quantity)
    else
      @current_cart.cart_items.create(product_id: @product.id, quantity: params[:quantity] || 1)
    end
    redirect_to current_cart_path
  end

  def show
    @total_quantity = @current_cart.cart_items.sum(:quantity)
    @tax_details = calculate_total_price_with_taxes(@current_cart.cart_items, @province)
    logger.info "GST Rate: #{@province.gst_rate}, PST Rate: #{@province.pst_rate}, HST Rate: #{@province.hst_rate}, QST Rate: #{@province.qst_rate}"
  end

  def checkout
    @tax_details = calculate_total_price_with_taxes(@current_cart.cart_items, @province)
  end

  def destroy
    @cart_item = @current_cart.cart_items.find_by(product_id: @product.id)
    @cart_item.destroy if @cart_item
    redirect_to current_cart_path
  end

  def update
    @cart_item = @current_cart.cart_items.find(params[:id])
    if @cart_item.update(quantity: params[:cart_item][:quantity])
      redirect_to current_cart_path, notice: 'Quantity updated successfully.'
    else
      redirect_to current_cart_path, alert: 'Failed to update quantity.'
    end
  end

  def stripe_session
    @tax_details = calculate_total_price_with_taxes(@current_cart.cart_items, @province)
    
    session = Stripe::Checkout::Session.create({
      ui_mode: 'embedded',
      line_items: [{
        price_data: {
          currency: "usd",
          unit_amount: (@tax_details[:total] * 100).to_i,
          product_data: {
            name: @current_cart.products.map(&:name).join(", ")
          },
        },
        quantity: 1,
      }],
      shipping_address_collection: {
        allowed_countries: STRIPE_SUPPORTED_COUNTRIES
      },
      mode: 'payment',
      return_url: success_cart_url(@current_cart.secret_id),
    })
  
    render json: { clientSecret: session.client_secret }
  end
  

  def success
    if @current_cart.cart_items.any?
      create_order(@current_cart, @current_customer)
      session[:current_cart_id] = nil
    end
    @purchased_cart = Cart.find_by_secret_id(params[:id])
    redirect_to root_path if !@purchased_cart
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
  
  def set_province
    @province = Province.find(params[:province_id]) if params[:province_id].present?
  end


  def set_current_customer
    @current_customer = current_customer
    @province = @current_customer&.province
  end

  def calculate_total_price_with_taxes(cart_items, province)
    tax_details = { subtotal: 0, gst: 0, pst: 0, hst: 0, qst: 0, total: 0 }
    
    cart_items.each do |item|
      item_price = item.product.price || BigDecimal("0")
      quantity = item.quantity || 1
      gst = item_price * (province.gst_rate || 0) * quantity
      pst = item_price * (province.pst_rate || 0) * quantity
      hst = item_price * (province.hst_rate || 0) * quantity
      qst = item_price * (province.qst_rate || 0) * quantity

      tax_details[:subtotal] += item_price * quantity
      tax_details[:gst] += gst
      tax_details[:pst] += pst
      tax_details[:hst] += hst
      tax_details[:qst] += qst
    end
    
    tax_details[:total] = tax_details[:subtotal] + tax_details[:gst] + tax_details[:pst] + tax_details[:hst] + tax_details[:qst]
    tax_details
  end

  def create_order(cart, customer)
    order = customer.orders.create(status: :complete)
    cart.cart_items.each do |cart_item|
      order.order_items.create(product: cart_item.product, quantity: cart_item.quantity)
    end
    cart.update(status: :complete)
  end
end
