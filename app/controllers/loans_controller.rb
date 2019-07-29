class LoansController < ApplicationController
  before_action :authenticate_user!

  #order the display of loans by displaying loans due msot soon first
  def index
    @loans = Loan.order('date_until asc')

    #filter to display those that are not returned
    @loans = @loans.where(:returned =>  false)

    render :index
  end

  def new
    @loan = Loan.new
    @item = Item.find(params[:item])
    render layout: false
  end

  def edit
    @loan = Loan.find(params[:id])
    @item = Item.find_by(id: @loan.item_id)
    render layout: false
  end

  def extend
    @loan = Loan.find(params[:id])
    @item = Item.find_by(id: @loan.item_id)
    render layout: false
  end

  #handles the instance a user wants to extend one of their current loans
  def update
    #gets the id of the item the user has selected
    @loan = Loan.find(params[:id])
    #stores the details of the selected item with the new extended date
    @newloan = Loan.new(loan_params)
    @item = Item.find_by(id: @loan.item_id)
    #gets all current loans of the selected item
    @others = @item.loan.where(returned: false)
    @others = @others.where.not(id: @loan.id)
    unavailable = false

    #checks if the extension date encroaches another persons reservation for the selected item
    for @other in @others do
      if (@loan.date_from <= @other.date_until && @other.date_from <= @newloan.date_until)
        #if encroaches reservation of someone else, sets unavailable to true
        unavailable = true
      end
    end

    if unavailable
      #refreshes page informing user that item has already been reserved for selected period
      redirect_to myloans_path, notice: "Sorry, item has already been reserved for that period"
    else
      #validates due date is not before start date
      if (@newloan.date_until < @loan.date_from)
        redirect_to myloans_path, notice: "Due date cannot be before the start date"
      else
        #validates due date is not before current date
        if (@newloan.date_until < Date.today)
          redirect_to myloans_path, notice: "Due date cannot be before current date"
        else
          #validates due date is not more than 3 months away from the date they are extending on
          if (@newloan.date_until > Date.today.next_month.next_month.next_month)
            redirect_to myloans_path, notice: "You can loan an item for maximum 3 months"
          else
            #if all validation passes, the extnsion date is updated
            if @loan.update(loan_params)
              #user receives email informing them of loan extension success
              PostsMailer.notify_user_extension(@loan, current_user).deliver_now
              redirect_to myloans_path, notice: 'Item was successfully extended.'
            else
              render :new
            end
          end
        end
      end
    end
  end

  #handles the instance a user takes out a loan
  def create
    @loan = Loan.new(loan_params)
    @item = Item.where(id: @loan.item_id).first
      #gets all current loans of the selected item
    @others = @item.loan.where(returned: false)
    unavailable = false

    #checks if the loan date encroaches another persons loaning for the selected item
    for @other in @others do
      if (@loan.date_from <= @other.date_until && @other.date_from <= @loan.date_until)
        #if encroaches loan of someone else, sets unavailable to true
        unavailable = true
      end
    end

    if unavailable
      #refreshes page informing user that item has already been loaned for selected period
      redirect_to items_url, notice: "Item is already on loan"
    else
      #validates due date is not before start date
      if (@loan.date_until < @loan.date_from)
        redirect_to items_url, notice: "Due date cannot be before the start date"
      else
          #validates due date or start date is not before current date
        if (@loan.date_until < Date.today) || (@loan.date_from < Date.today)
          redirect_to items_url, notice: "Start date and/or due date cannot be before current date"
        else
            #validates start date is not more than 3 months away from the date they are loaning on
          if @loan.date_from > Date.today.next_month.next_month.next_month
            redirect_to items_url, notice: "Start date of an item can only be up to 3 months in advance"
          else
            #validates loan period is not more than 3 months
            if @loan.date_until > @loan.date_from.next_month.next_month.next_month
              redirect_to items_url, notice: "You can loan an item for maximum 3 months"
            else
              #if all validation passes, the loan is created
              if @loan.save
                #notify user and admin when a loan has been taken out
                PostsMailer.notify_user_loan(@loan, current_user).deliver_now
                PostsMailer.notify_admin_loan(@loan, current_user).deliver_now

                #sends an email to the user if the loan is a reservation and it has available for collection
                if (@loan.date_from > Date.today)
                  @available = @loan.date_from - Time.now
                  PostsMailer.notify_reserved_is_available(@loan).deliver_later(wait: @available.seconds)
                end

                #sends an email to the loan holder when there are 2 days left before a loan must be returned
                @twodaynotice = (((@loan.date_until - Time.now)) - 172800)
                PostsMailer.notify_user_soon_due(@loan).deliver_later(wait: @twodaynotice.seconds)


                # sends an email to both the admin and loan holder when the item has become overdue
                @overdue = (( @loan.date_until - Time.now))
                PostsMailer.notify_user_overdue(@loan).deliver_later(wait: @overdue.seconds)
                PostsMailer.notify_admin_overdue(@loan, current_user).deliver_later(wait: @overdue.seconds)

                #refreshes the page showing the new loan in the user's myloans view
                redirect_to myloans_path, notice: 'Item was successfully loaned.'
              else
                render :new
              end
            end
          end
        end
      end
    end

  end

  def show
    @loan
  end

  #handles the instance an admin confirms the return of one or more items
  def returned
    #gets the loan id that relates to the current selected checkboxes
    if ( params[:loan_ids].present?)
      @loans = Loan.find(params[:loan_ids])

      @loans.each do |loan|
        loan.update(returned: true)
        loan.update(request: false)
      end
      PostsMailer.notify_user_return(@loans).deliver_now

      redirect_to loans_url, notice: 'Item was successfully returned.'
    else
      redirect_to loans_url, notice: 'You must tick the boxes to return items'
    end


    #notify a student there item return request has been accepted


  end

  #handles the instance a user wants to cancel a reservation
  def destroy
    @loan = Loan.find(params[:id])
    #updates teh request status of the loan to true
    @loan.update(request: true)
    #sends confirmation email to user
    PostsMailer.notify_user_cancel_reserved(@loan, current_user).deliver_now
    #sends email to admin informing them of a new cancellation request
    PostsMailer.notify_admin_cancel_reserved(@loan, current_user).deliver_now
    redirect_to myloans_path, notice: 'Reservation cancellation request successfully sent.'
  end

  #handles the isntnace a user wants to send one or more return requests
  def returnRequest
    #an array of all the loans not already requested
    @unrequestedLoans = []
    if (params[:loan_ids].present?)
      #gets the loan id that relates to the current selected checkboxes

      @loans = Loan.find(params[:loan_ids])
      @loans.each do |loan|
        #sets each loans return request status to true
        if loan.request == false
          loan.update(request: true)
          @unrequestedLoans.push(loan)
        end
      end
      redirect_to myloans_path, notice: 'Items requests have been successfully sent'
    else
      redirect_to myloans_path, notice: 'You must select items to return'


    end
    if (@unrequestedLoans.length > 0 )
      #sends confirmation email to user, if their item has not already been requested

      PostsMailer.notify_user_return_request(@unrequestedLoans, current_user).deliver_now
      #sends email to admin informing them of a new return request
      PostsMailer.notify_admin_return_request(@unrequestedLoans, current_user).deliver_now



    end


  end

  #handles the isntance an admin wants to view the details of a loans holder
  def View_User
    @user = User.find(params[:id])
    render :showuser, layout: false
  end

  #handles the display of loans on th myloans page
  def myloans

    #orders curent loans by those due most soon
    @loans = Loan.where(user_id: current_user.id).order('date_until asc')
    #orders reservations by those that are most soon
    @reservations = Loan.where(user_id: current_user.id).order('date_from asc')

    #filter those that are not returned
    @loans = @loans.where(:returned =>  false)
    @reservations = @reservations.where(:returned =>  false)

    #filters between loans that are current and loans that are reserved
    @loans = @loans.where("date_from <= ?", Time.now)
    @reservations = @reservations.where("date_from >= ?", Time.now)
    @available = @reservations.where(:returned => true)
    render :myloans
  end


  #handles searching for a loan
  def search
    #order the display of loans by displaying loans due msot soon first
    @loans = Loan.order('date_until asc')

    #filter by name of loanee
    @loans = @loans.joins(:user).where("givenname like ?", "%#{params[:search][:name_of_loanee]}%").or(@loans.joins(:user).where("sn like ?", "%#{params[:search][:name_of_loanee]}%")) if params[:search][:name_of_loanee].present?

    #filter by item name
    @loans = @loans.joins(:item).where("name like ?", "%#{params[:search][:name_of_item]}%") if params[:search][:name_of_item].present?

    #filter by overdue
    if params[:search][:Overdue] == "true"
        @loans = @loans.where("date_until <= ?", Time.now) if params[:search][:Overdue].present?
    end

    #filter by requested a return
    if params[:search][:Requested_return] == "true"
      @loans = @loans.where("request = ?", "true") if params[:search][:Requested_return].present?
    end

    #filter those that are not returned
    @loans = @loans.where(:returned =>  false)

    render :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end
    def set_loan
      @loan = Loan.find(params[:id])
    end
    def send_available
      PostsMailer.notify_reserved_is_available(@loan).deliver_now
    end

    # Only allow a trusted parameter "white list" throucurrent_usergh.
    def loan_params
      params.require(:loan).permit(:user_id, :item_id, :date_from, :date_until, :returned, :request)
    end
end
