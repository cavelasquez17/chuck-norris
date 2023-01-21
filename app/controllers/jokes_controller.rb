require 'uri'
require 'net/http'
class JokesController < ApplicationController
  def get_joke
    url = URI('https://api.chucknorris.io/jokes/random')
    response = Net::HTTP.get(url)
    JSON.parse(response)['value']
  end
end
