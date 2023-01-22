class Joke < ApplicationRecord
  belongs_to :user
  before_create :send_to_supabase

  private

  def send_to_supabase
    url = URI(ENV['SUPABASE_BASE_URL'].to_s)
    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true
    request = Net::HTTP::Post.new(url, 'Content-Type' => 'application/json', "Prefer" => "return=minimal")
    request['Authorization'] = "Bearer #{ENV['SUPABASE_KEY']}"
    request['apikey'] = "#{ENV['SUPABASE_KEY']}"
    request.body =  { 'content': self.content.to_s, 'user_id': self.user_id.to_s }.to_json
    https.request(request)
  end
end
