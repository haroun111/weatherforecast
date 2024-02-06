require 'net/http'
require 'json'

class WeatherService
  OPENWEATHERMAP_API_URL = Rails.application.credentials.openweathermap[:api_url]
  OPENWEATHERMAP_API_KEY = Rails.application.credentials.openweathermap[:api_key]

  class << self
    def current_weather(city)
      fetch_weather('weather', city)
    end

    def weather_forecast(city)
      fetch_weather('forecast', city)
    end

    private

    def fetch_weather(endpoint, city)
      url = "#{OPENWEATHERMAP_API_URL}#{endpoint}?q=#{city}&appid=#{OPENWEATHERMAP_API_KEY}&units=metric"
      uri = URI(url)
      begin
        response = Net::HTTP.get(uri)
        JSON.parse(response)
      rescue StandardError => e
        Rails.logger.error("Error fetching weather data: #{e.message}")
        nil
      end
    end
  end
end