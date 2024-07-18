class ChangeDefaultStatusInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column_default :carts, :status, 0
  end
end
