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

  def my_jokes
    @jokes = get_my_jokes
  end

  private
  
  def get_joke
    url = URI(ENV['CHUCK_NORRIS_URL'].to_s)
    response = Net::HTTP.get(url)
    JSON.parse(response)['value']
  end

  def get_my_jokes
    url = URI("#{ENV['SUPABASE_BASE_URL']}?user_id=eq.#{current_user.id}&select=*")
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Get.new(url, 'Content-Type' => 'application/json', 'Accept-Encoding' => 'utf-8')
    request['Authorization'] = "Bearer #{ENV['SUPABASE_KEY']}"
    request['apikey'] = "#{ENV['SUPABASE_KEY']}"
    response = https.request(request)
    JSON.parse(response.body)
  end

  def message_params
    params.permit(:content, :authenticity_token, :user_id)
  end
end
