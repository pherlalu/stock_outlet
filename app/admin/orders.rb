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

  filter :customer
  filter :order_date
  filter :total
  filter :province
  filter :created_at
  filter :updated_at

  controller do
    def scoped_collection
      super.includes(:customer, order_items: :product)
    end
  end
end
