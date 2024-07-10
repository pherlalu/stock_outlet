# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
  user.password = 'password'
  user.password_confirmation = 'password'
end if Rails.env.development?

require 'csv'
csv_file = Rails.root.join('db/products/master_product_list.csv')

if File.exist?(csv_file)
  csv_data = File.read(csv_file)
  products = CSV.parse(csv_data, headers: true)

  products.each do |product|

    Product.create(
      name: product['product_name'],
      description: product['product_description'],
      price: product['product_price'],
      product_image: product['product_image-src'],
      product_link: product['product-href'],
      product_styleno: product['product_color'],

    )
  end
else
  puts "CSV file not found"
end
