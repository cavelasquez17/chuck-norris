require 'uri'
require 'net/http'
class JokesController < ApplicationController
  before_action :authenticate_user!

  def new
    @joke = current_user.jokes.new(content: get_joke, user: current_user)
  end

  def create
    current_user.jokes.create(user: current_user, content: message_params[:content])
  end

  private
  
  def get_joke
    url = URI('https://api.chucknorris.io/jokes/random')
    response = Net::HTTP.get(url)
    JSON.parse(response)['value']
  end

  def my_jokes
  end

  def message_params
    params.permit(:content, :authenticity_token, :user_id)
  end
end
