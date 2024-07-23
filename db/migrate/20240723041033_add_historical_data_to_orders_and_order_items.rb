class AddHistoricalDataToOrdersAndOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_column :order_items, :historical_unit_price, :decimal, precision: 10, scale: 2
    add_column :order_items, :historical_subtotal, :decimal, precision: 10, scale: 2
    add_column :orders, :historical_gst_rate, :decimal, precision: 5, scale: 3
    add_column :orders, :historical_pst_rate, :decimal, precision: 5, scale: 3
    add_column :orders, :historical_hst_rate, :decimal, precision: 5, scale: 3
    add_column :orders, :historical_qst_rate, :decimal, precision: 5, scale: 3
  end
end
