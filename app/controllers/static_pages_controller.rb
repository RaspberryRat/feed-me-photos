class StaticPagesController < ApplicationController
  def index
    @photographer = StaticPage.new(params[:photographer_id])
    @photo_list = @photographer.return_list

    flash.now[:error] = "User doesn't exist" if @photo_list == false

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
