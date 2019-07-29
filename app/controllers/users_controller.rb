class UsersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @users = User.all
    render :index
    #redirect_to :controller => 'loans', :action => 'myloans'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def update
    @user = User.find(params[:id])
    if @user.admin == true
      @user.update(admin: false)
    else
      @user.update(admin: true)
    end
    @users = User.all
    render :index
  end

  def search
    @users = User.all
    @users = @users.where("givenname like ?", "%#{params[:search][:user]}%").or(@users.where("sn like ?", "%#{params[:search][:user]}%")) if params[:search][:user].present?
    render :index
  end

  def destroy
    @user.destroy
  end

end
