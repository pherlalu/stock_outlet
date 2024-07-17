ActiveAdmin.register Province do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :gst_rate, :pst_rate, :hst_rate, :qst_rate
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :gst_rate, :pst_rate, :hst_rate, :qst_rate]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :gst_rate, :pst_rate, :hst_rate, :qst_rate

  form do |f|
    f.inputs 'Province Details' do
      f.input :name
      f.input :gst_rate
      f.input :pst_rate
      f.input :hst_rate
      f.input :qst_rate
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :gst_rate
    column :pst_rate
    column :hst_rate
    column :qst_rate
    actions
  end

  show do
    attributes_table do
      row :name
      row :gst_rate
      row :pst_rate
      row :hst_rate
      row :qst_rate
      row :created_at
      row :updated_at
    end
  end
end
