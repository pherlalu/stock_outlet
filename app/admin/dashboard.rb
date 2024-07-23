# frozen_string_literal: true
ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    columns do
      column do
        panel "Customer Orders" do
          ul do
            li link_to "View Customer Orders", admin_customer_orders_path
          end
        end
      end

      
    end

    columns do
      column do
        panel "Top Customers" do
          table_for Customer.joins(:orders).select('customers.*, SUM(orders.total) as total_spent').group('customers.id').order('total_spent DESC').limit(10) do
            column("Customer") { |customer| link_to customer.username, admin_customer_path(customer) }
            column("Total Spent") { |customer| number_to_currency customer.total_spent }
          end
        end
      end

      
    end
  end
end
