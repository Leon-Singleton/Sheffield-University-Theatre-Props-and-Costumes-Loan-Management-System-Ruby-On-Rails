class PagesController < ApplicationController

  def home
    @current_nav_identifier = :home
    @items = Item.all.last(5)
    render :home
  end
  
  def show_image
    @item = Item.find(params[:id])
    send_file @item.item_image_file.url, disposition: 'inline'
  end
end
