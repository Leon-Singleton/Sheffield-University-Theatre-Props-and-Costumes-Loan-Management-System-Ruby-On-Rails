class SubcategoriesController < ApplicationController
  before_action :set_subcategory, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  authorize_resource

  #orders the display of subcategories alphabetically
  def index
      @subcategories = Subcategory.all.order('name asc')
  end

  def edit
    render layout: false
  end

  def new
    @subcategory = Subcategory.new
    render layout: false
  end

  #handles adding a new subcategory
  def create
    @subcategory = Subcategory.new(subcategory_params)
    if @subcategory.save
      #refreshes the page and displays message informing user of successfull action
      redirect_to categories_path, notice: 'Sub-Category was created.'
    else
      render :new
    end
  end

  #handles editing an exisitng subcategory
  def update
    if @subcategory.update(subcategory_params)
      #refreshes the page and displays message informing user of successfull action
       redirect_to categories_path, notice: 'Sub-Category was successfully updated.'
    else
      render :edit
    end
  end

  #handles the removal of a subcategory
  def destroy
    @subcategory.destroy
    #refreshes the page and displays message informing user of successfull action
    redirect_to categories_path, notice: 'Sub-Category was successfully removed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcategory
      @subcategory = Subcategory.find(params[:id])
    end

    def subcategory_params
      params.require(:subcategory).permit(:name, :category_id)
    end

end
