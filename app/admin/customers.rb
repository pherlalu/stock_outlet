ActiveAdmin.register Customer do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :username, :email, :password, :province_id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :email, :password, :province_id, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :username, :email, :password, :province_id, :address, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at

  form do |f|
    f.inputs 'Customer Details' do
      f.input :username
      f.input :email
      f.input :password
      f.input :province, as: :select, collection: Province.all.collect { |p| [p.name, p.id] }
      f.input :address
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :province
    column :address
    actions
  end

  show do
    attributes_table do
      row :username
      row :email
      row :province
      row :address
      row :created_at
      row :updated_at
    end
  end

  filter :username
  filter :email
  filter :province
  filter :address
  filter :created_at
end
