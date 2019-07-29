class HistoriesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    #orders all loans by descending order of date, showing the msot recent returns first
    @histories = Loan.order('date_until desc')

    #filters the loans to only display those that have been returned
    @histories = @histories.where(:returned =>  true)
  end

  #handles the searching of loans in the history, can use a combiantion of search fields
  def search

    #orders all loans by descending order of date, showing the msot recent returns first
    @histories = Loan.order('date_until asc')

    #filter by name of loanee
    @histories = @histories.joins(:user).where("givenname like ?", "%#{params[:search][:name_of_loanee]}%").or(@histories.joins(:user).where("sn like ?", "%#{params[:search][:name_of_loanee]}%")) if params[:search][:name_of_loanee].present?

    #filter by item name
    @histories = @histories.joins(:item).where("name like ?", "%#{params[:search][:name_of_item]}%") if params[:search][:name_of_item].present?

    #filter by category and sub category
    @histories = @histories.joins(:item).where("category_id = ?", params[:search][:category_id]) if params[:search][:category_id].present?
    @histories = @histories.joins(:item).where("subcategory_id = ?", params[:search][:subcategory_id]) if params[:search][:subcategory_id].present?

    #filters the loans to only display those that have been returned
    @histories = @histories.where(:returned =>  true)

    render :index
  end

  #method to handle the redirection to the statistics page
  def show
    render :statistics
  end

  #handles the users date inputs to load the corresponding category and subcategory statistics for the chosen period
  def statistics

    #gets the user date from and date until input from the webpage
    @a = params[:statistics]
    @b = params[:statistics]
    @dfrom = Date.new @a["datefrom(1i)"].to_i, @a["datefrom(2i)"].to_i, @a["datefrom(3i)"].to_i
    @dtil = Date.new @b["datetil(1i)"].to_i, @b["datetil(2i)"].to_i, @b["datetil(3i)"].to_i

    #gets the users category choice from the webpage and gets the database id of it
    @category_id = @a['category_id'].to_i

    #Generates the statistics of how many items corresponding to the chosen category have been taken out during the chosen time period
    @histories = Loan.joins("INNER JOIN items ON item_id = items.id")
    @histories = @histories.where("date_from > ?",  @dfrom)
    @histories = @histories.where("date_until < ?", @dtil)
    @loanData = @histories.select("categories.name").joins("INNER JOIN categories ON items.category_id = categories.id")
    @loanData= @loanData.group("categories.name").count

    #generates the statistics to show the popularity of the subcategories of the chosen category
    @categories = Loan.joins("INNER JOIN items ON item_id = items.id")
    @categories = @categories.select("subcategories.name").joins("INNER JOIN subcategories ON items.subcategory_id = subcategories.id").where("subcategories.category_id = ?", @category_id) if @category_id.present?
    @categoryData = @categories.group("subcategories.name").count

  end


end
