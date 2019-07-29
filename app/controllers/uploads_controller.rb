class UploadsController < ApplicationController

  before_action :authenticate_user!

  def upload_items
    file = params[:upload_items][:file].tempfile
    importer = Imports::Importer.new(file)
    if importer.import == true
      flash.now[:alert] = 'Success'
      PostsMailer.notify_admin_csv_upload(@items, current_user).deliver_now
      redirect_to items_path
    else
      flash.now[:alert] = importer.import
      render :new
    end

  end
end
