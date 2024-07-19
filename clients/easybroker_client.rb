require 'httparty'

class EasybrokerClient
  include HTTParty
  base_uri 'https://api.stagingeb.com/v1'

  def initialize
    @headers = {
      "X-Authorization" => ENV['API_KEY'],
      "Content-Type" => "application/json"
    }
  end

  def get_properties(page,limit)
    self.class.get("/properties?page=#{page}&limit=#{limit}", headers: @headers)
  end
end