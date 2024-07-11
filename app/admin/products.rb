ActiveAdmin.register Product do
  permit_params :name, :description, :price, :product_image, :product_link, :product_styleno, :on_sale, :added_at, category_ids: []

  scope :all, default: true
  scope :on_sale
  scope :new_products
  scope :recently_updated

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :product_image do |product|
      image_tag product.product_image, size: "100x100" if product.product_image.present?
    end
    column :on_sale
    column :added_at
    column :created_at
    column :updated_at
    column "Main Categories" do |product|
      product.categories.where(sub_category_id: nil).map(&:name).join(", ")
    end
    column "Subcategories" do |product|
      product.categories.where.not(sub_category_id: nil).map(&:name).join(", ")
    end
    actions
  end

  filter :name
  filter :description
  filter :price
  filter :on_sale
  filter :added_at
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :product_image
      f.input :product_link
      f.input :product_styleno
      f.input :on_sale
      f.input :added_at, as: :datepicker
      f.input :category_ids, as: :check_boxes, collection: Category.where(sub_category_id: nil), label: "Main Categories"
      f.input :category_ids, as: :check_boxes, collection: Category.where.not(sub_category_id: nil), label: "Subcategories"
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :product_image do |product|
        image_tag product.product_image if product.product_image.present?
      end
      row :product_link
      row :product_styleno
      row :on_sale
      row :added_at
      row :created_at
      row :updated_at
      row "Main Categories" do |product|
        product.categories.where(sub_category_id: nil).map(&:name).join(", ")
      end
      row "Subcategories" do |product|
        product.categories.where.not(sub_category_id: nil).map(&:name).join(", ")
      end
    end
    active_admin_comments
  end
end
