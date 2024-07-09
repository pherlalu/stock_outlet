class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.references :order, null: false, foreign_key: true
      t.timestamp :invoice_date
      t.decimal :total
      t.string :payment_method

      t.timestamps
    end
  end
end
