class StaticPagesController < ApplicationController
  def index
    @photographer_id = params[:photographer_id]
    @owner_id = StaticPage.find_owner(@photographer_id)
    @url = StaticPage.find_user_photos(@owner_id)

    respond_to do |format|
      format.html
      format.json { render json: @url }
      format.xml { render xml: @url }
    end
  end

  private

  def photo_params
    params.permit(:photographer_id)
  end
end
