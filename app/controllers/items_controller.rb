class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token

  #orders the display of items by alphabetical ordering
  def index
    @items = Item.all.order('name asc')
  end

  def new
    @item = Item.new
    render layout: false
  end

  def show_image
    @item = Item.find(params[:id])
    send_file @item.item_image_file.url, disposition: 'inline'
  end


  def edit
    render layout: false
  end

  #handles adding a new item to the catalogue
  def create
    @item = Item.new(item_params)
    #if the entered details are valid then the item is added to the database
    if @item.save
      #admin receives a confirmation email for adding an item
      PostsMailer.notify_admin_add_item(@item, current_user).deliver_now
      #Page is refreshed to show the newly added item
      redirect_to items_path, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  #handles editing an item within the catalogue
  def update
    if @item.update(item_params)
      #Page is refreshed to show the newly edited item
      redirect_to items_url, notice: 'Item was successfully updated.'
    end
  end

  #handles removing an item from the catalogue
  def destroy
    @item.destroy
    #Page is refreshed to show the item removed
    redirect_to items_url, notice: 'Item was successfully removed.'
  end

  #handles searching for an item in the catalogue, search can be done using a combination of the input fields
  def search
    #orders all items alphabetically
    @items = Item.all.order('name asc')
    #filters by category choice
    @items = @items.where(category_id: params[:search][:category_id]) if params[:search][:category_id].present?
    #filters by subcategory choice
    @items = @items.where(subcategory_id: params[:search][:subcategory_id]) if params[:search][:subcategory_id].present?
    #filters by item where any text within an items name matches the input
    @items = @items.where("name like ?", "%#{params[:search][:name]}%") if params[:search][:name].present?
    #filters by colour choice
    @items = @items.where(colour_id: params[:search][:colour_id]) if params[:search][:colour_id].present?

    render :index
  end

  #handles the subcategory slecetion box to update to show the corresponding subcategories of the current selected category
  def filter_subcategories_by_categories
    @filtered_subcategories = Subcategory.where(cateogry_id: params[:selected_category])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def item_params
      params.require(:item).permit(:name, :code, :description, :colour, :costume, :subcategory_id, :category_id, :colour_id,
:item_image_file, :item_image_file_cache)
    end
end
