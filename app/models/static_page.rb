require "rest-client"
require "JSON"

class StaticPage < ApplicationRecord
  attr_reader :user_id

  def initialize(user_id)
    @user_id = user_id
  end

  def return_list
    return nil if user_id.nil?

    owner = find_owner(user_id)
    return false unless owner

    convert_to_json(find_user_photos(owner).to_s)
  end

  private

  def convert_to_json(response)
    response = response.split("[").last.split("]").first
    response.prepend("[").concat("]")

    JSON.parse(response)
  end

  def find_user_photos(user_id)
    api_url =
      "https://www.flickr.com/services/rest/?method=flickr.people.getPublicPhotos&"
    api_key = ENV["flickr_key"]

    x =
      make_api_request(
        "#{api_url}api_key=#{api_key}&user_id=#{user_id}&format=json"
      )
    debugger
    return
  end

  def find_owner(user_id)
    api_response = self.search_request(user_id)

    return false unless valid_owner?(api_response)

    str_start = "owner=\""
    str_end = "\""

    # gets the owner id from response
    api_response.split(str_start).last.split(str_end).first
  end

  def valid_owner?(response)
    return false unless response.include?("owner")

    true
  end

  def as_json(options = {})
    super({ only: %i[id secret server] })
  end

  def make_api_request(url)
    RestClient.get(url, accept: :json)
  end

  def search_request(user_id)
    api_url =
      "https://www.flickr.com/services/rest/?method=flickr.photos.search&"
    api_key = ENV["flickr_key"]

    make_api_request(
      "#{api_url}api_key=#{api_key}&user_id=#{user_id}&format=rest"
    )
  end
end
