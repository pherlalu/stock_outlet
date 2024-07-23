ActiveAdmin.register_page "Customer Orders" do
  menu priority: 2, label: "Customer Orders"

  content title: "Customer Orders" do
    panel "Customer Orders" do
      table_for Customer.joins(orders: :order_items).distinct do
        column "Customer Name" do |customer|
          link_to customer.username, admin_customer_path(customer)
        end
        column "Orders" do |customer|
          div do
            customer.orders.each do |order|
              div class: "order-details" do
                h3 do
                  link_to "Order ##{order.id} - #{order.order_date.strftime('%B %d, %Y')}", admin_order_path(order)
                end
                total_taxes = 0
                table style: "width: 100%;" do
                  thead do
                    tr do
                      th "Product", style: "width: 40%;"
                      th "Quantity", style: "width: 10%;"
                      th "Unit Price", style: "width: 10%;"
                      th "Subtotal", style: "width: 10%;"
                      th "Taxes", style: "width: 10%;"
                    end
                  end
                  tbody do
                    order.order_items.each do |item|
                      tr do
                        td item.product.name, style: "width: 40%;"
                        td item.quantity, style: "width: 10%;"
                        td number_to_currency(item.unit_price), style: "width: 10%;"
                        td number_to_currency(item.subtotal), style: "width: 10%;"
                        tax_amount = 0
                        td do
                          if customer.province.pst_rate.present?
                            tax_amount += item.subtotal * customer.province.pst_rate
                          end
                          if customer.province.gst_rate.present?
                            tax_amount += item.subtotal * customer.province.gst_rate
                          end
                          if customer.province.hst_rate.present?
                            tax_amount += item.subtotal * customer.province.hst_rate
                          end
                          if customer.province.qst_rate.present?
                            tax_amount += item.subtotal * customer.province.qst_rate
                          end
                          total_taxes += tax_amount
                          number_to_currency(tax_amount)
                        end
                      end
                    end
                  end
                end
                div do
                  strong "Total: "
                  span number_to_currency(order.total)
                end
                div do
                  strong "Total Taxes: "
                  span number_to_currency(total_taxes)
                end
                div do
                  strong "Grand Total: ", style: "font-size: 1.2em; color: #000;"
                  span number_to_currency(order.total + total_taxes), style: "font-size: 1.2em; color: #000;"
                end
              end
              hr
            end
          end
        end
        column "Total Spent" do |customer|
          number_to_currency customer.orders.sum(:total)
        end
      end
    end
  end
end
