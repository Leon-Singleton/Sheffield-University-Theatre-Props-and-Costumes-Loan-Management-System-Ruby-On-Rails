class ColoursController < ApplicationController
  before_action :set_colour, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  authorize_resource

  #orders the display of colours by alphabetical ordering
  def index
      @colours = Colour.all.order('name asc')
  end

  def show
     @colour = Colour.find(params[:id])
  end

  def edit
    render layout: false
  end

  def new
    @colour = Colour.new
    render layout: false
  end

  #handles adding a new colour
  def create
    @colour = Colour.new(colour_params)
    if @colour.save
      #refreshes the page showing the newly added colour
      redirect_to colours_path, notice: 'Colour was created.'
    else
      render :new
    end
  end

  #handles editing an existing colour
  def update
    if @colour.update(colour_params)
      #refreshes the page showing the newly edited colour
       redirect_to colours_path, notice: 'Colour was successfully updated.'
    else
      render :edit
    end
  end

  #handles removing an existing colour
  def destroy
    @colour.destroy
    #refreshes the page showing the removed colour
    redirect_to colours_url, notice: 'Colour was successfully removed.'
  end

  #handles searching for a colour
  def search
    #search is done by name of colour and will order results alphabetically
    @colours = Colour.all.order('name asc')
    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_colour
      @colour = Colour.find(params[:id])
    end

    def colour_params
      params.require(:colour).permit(:name)
    end

end
