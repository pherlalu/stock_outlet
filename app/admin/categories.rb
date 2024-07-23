ActiveAdmin.register Category do
  permit_params :name, :description, sub_categories_attributes: [:id, :name, :description, :_destroy]

  index do
    selectable_column
    id_column
    column :name
    column "Sub Categories" do |category|
      category.sub_categories.map(&:name).join(', ')
    end
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :parent_category, as: :select, collection: Category.where.not(id: f.object.id).map { |c| [c.name, c.id] }, include_blank: "None"
      f.has_many :sub_categories, allow_destroy: true, new_record: true do |s|
        s.input :name
        s.input :description
      end
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:sub_categories).where.not(sub_categories: { id: nil })
    end

    def find_resource
      scoped_collection.find_by(name: params[:id])
    end

    def destroy
      category = find_resource
      category.product_categories.destroy_all # Deleting associated product categories

      if category.destroy
        flash[:notice] = "Category was successfully deleted."
      else
        flash[:error] = "Category could not be deleted."
      end

      redirect_to admin_categories_path
    end

    def edit
      @category = find_resource
      @category.sub_categories.build if @category.sub_categories.empty?
      super
    end
  end
end
