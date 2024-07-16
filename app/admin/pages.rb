ActiveAdmin.register Page do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :content, :slug
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content, :slug]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  permit_params :title, :content, :slug

  form do |f|
    f.inputs do
      f.input :title
      f.input :content, as: :text
      f.input :slug
    end
    f.actions
  end
  
end
