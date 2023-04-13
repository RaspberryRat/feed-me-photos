require "flickr"
require "figaro"
class StaticPagesController < ApplicationController
  def index
    flickr = Flickr.new Figaro.env.flickr_key, Figaro.env.flickr_secret
    debugger

    @photographer = params[:photographer_id]

    begin
      unless @photographer.blank?
        @photo_list = flickr.photos.search(user_id: @photographer)
      end
    rescue StandardError
      flash.now[:error] = "User doesn't exist"
      @photo_list = nil
    end
  end
end
