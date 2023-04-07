require "rest-client"

class StaticPage < ApplicationRecord
  def self.find_user_photos(user_id)
    api_url =
      "https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&"
    api_key = ENV["flickr_key"]

    self.make_api_request(
      "#{api_url}api_key=#{api_key}&user_id=#{user_id}&format=rest"
    )
  end

  def self.find_owner(user_id)
    api_response = self.search_request(user_id)

    str_start = "owner=\""
    str_end = "\""

    # gets the owner id from response
    api_response.split(str_start).last.split(str_end).first
  end

  private

  def self.make_api_request(url)
    RestClient.get(url, accept: :json)
  end

  def self.search_request(user_id)
    api_url =
      "https://www.flickr.com/services/rest/?method=flickr.photos.search&"
    api_key = ENV["flickr_key"]

    self.make_api_request(
      "#{api_url}api_key=#{api_key}&user_id=#{user_id}&format=rest"
    )
  end
end
