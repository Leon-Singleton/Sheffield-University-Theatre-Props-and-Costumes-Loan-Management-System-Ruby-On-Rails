class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  authorize_resource

  #orders the display of categories by alphabetical ordering
  def index
      @categories = Category.all.order('name asc')
      @subcategories = Subcategory.all.order('name asc')
  end

  #gets a categories associated subcategories then orders them by alphabetical ordering
  def show
     @category = Category.find(params[:id])
     @subcategories = @category.subcategories.order('name asc')
     render :show
  end

  def edit
    render layout: false
  end


  def new
    @category = Category.new
    render layout: false
  end

  #handles adding a new category
  def create
    @category = Category.new(category_params)
    if @category.save
      #refreshes the page showing the newly added category
      redirect_to categories_path, notice: 'Category was created.'
    else
      render :new
    end
  end

  #handles updating an existing category
  def update
    if @category.update(category_params)
      #refreshes the page showing the newly edited category
       redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  #handles deleting an existing category
  def destroy
    @category.destroy
    #refreshes the page showing the category removed
    redirect_to categories_url, notice: 'Category was successfully removed.'
  end

  #handles searching for a category
  def search
    #search is done by name of category and will order results alphabetically
    @categories = Category.all.order('name asc')
    @categories = @categories.where(category_id: params[:search][:category_id]) if params[:search][:category_id].present?
    render :index
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def category_params
      params.require(:category).permit(:name, :category_id)
    end

end
