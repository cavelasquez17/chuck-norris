class JokesController < ApplicationController
  require 'uri'
  require 'net/http'

  def get_joke
    url = URI('https://api.chucknorris.io/jokes/random')
    https = Net::HTTP.new(url.host, url.port)
    request = Net::HTTP::Get.new(url)
    request['Content-Type'] = 'application/x-www-form-urlencoded'
    byebug
    response = https.request(request)
    parsed_response = JSON.parse(response.read_body)
  end
end
