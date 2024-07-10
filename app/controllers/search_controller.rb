class SearchController < ApplicationController

  # Render the app/views/search/index.html.erb
  # Which is a search form that will POST to the
  # results action.
  def index
  end

  # After searching using ActiveRecord will display
  # the search results in the app/views/search/results.html.erb
  def results
    @products = Product.all
    @products = @products.where('products.name LIKE ?', "%#{params[:search]}%") if params[:search].present?
    # if params[:search].present?
    #   keyword = "%#{params[:search]}%"
    #   @products = @products.where('products.name LIKE ? OR products.description LIKE ?', keyword, keyword)
    # end
    
    if params[:category].present? && params[:category].to_i > 0
      category = Category.find_by(id: params[:category])
      if category
        @products = @products.joins(:categories).where(categories: { id: category.subtree_ids })
      end
    end
  end
end