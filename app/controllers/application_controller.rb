require 'net/https'
require 'uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def get_request_token_uri()
    "#{Rails.application.config.BASE_URL}/oauth/authorize?client_id=#{Rails.application.config.OAUTH_CLIENT_ID}&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Foauth"
  end

  def get_access_token(request_token)
    uri = URI.parse("#{Rails.application.config.BASE_URL}/oauth/token?client_id=#{Rails.application.config.OAUTH_CLIENT_ID}&client_secret=#{Rails.application.config.OAUTH_SHARED_SECRET}&grant_type=authorization_code&redirect_uri=http%3A%2F%2Flocalhost%3A3000%2Foauth&code=#{request_token}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    json = JSON.parse response.body
    json['access_token']
  end
end
