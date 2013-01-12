require 'net/https'
require 'uri'
require 'json'

class SlcResource
  def self.fetch_resource(uri, token)
    clean_uri = uri.sub(/^\//, '')

    uri = URI.parse("#{Rails.application.config.REST_URL}/#{clean_uri}")
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(uri.request_uri)
    request.add_field("Content-Type", "application/vnd.slc+json")
    request.add_field("Accept", "application/vnd.slc+json")
    request.add_field("Authorization", "bearer #{token}")

    response = http.request(request)
    JSON.parse(response.body)
  end

  def self.fetch_sections(token)

  end
end
