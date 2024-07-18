class AddAddressToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_column :customers, :address, :string
    drop_table :customer_addresses
  end
end
