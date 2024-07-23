ActiveAdmin.register Order do
  includes :customer, order_items: :product

  index do
    selectable_column
    id_column
    column "Customer" do |order|
      link_to order.customer.username, admin_customer_path(order.customer)
    end
    column :order_date
    column :total
    column :province
    column :status
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :customer
      row :order_date
      row :total
      row :province
      row :stripe_payment_id
      row :status
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :unit_price
        column :subtotal
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :customer
      f.input :order_date
      f.input :total
      f.input :province
      f.input :status, as: :select, collection: Order.statuses.keys
      f.input :stripe_payment_id
    end
    f.actions
  end

  filter :customer
  filter :order_date
  filter :total
  filter :province
  filter :status
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.includes(:customer, order_items: :product)
    end

    def update
      @order = Order.find(params[:id])
      if @order.update(permitted_params[:order])
        redirect_to admin_order_path(@order), notice: 'Order was successfully updated.'
      else
        render :edit
      end
    end

    private

    def permitted_params
      params.permit(order: [:customer_id, :order_date, :total, :province_id, :status, :stripe_payment_id])
    end
  end
end
