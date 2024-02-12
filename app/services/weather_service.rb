require 'net/http'
require 'json'

class WeatherService
  OPENWEATHERMAP_API_URL = Rails.application.credentials.openweathermap[:api_url]
  OPENWEATHERMAP_API_KEY = Rails.application.credentials.openweathermap[:api_key]

  class << self
    def current_weather(city, latitude, longitude)
      fetch_weather('weather', city, latitude, longitude)
    end

    def weather_forecast(city, latitude, longitude)
      fetch_weather('forecast', city, latitude, longitude)
    end

    private

    def fetch_weather(endpoint, city, latitude, longitude)
      if latitude.present? && longitude.present?
        url = "#{OPENWEATHERMAP_API_URL}#{endpoint}?lat=#{latitude}&lon=#{longitude}&appid=#{OPENWEATHERMAP_API_KEY}&units=metric"
      else
        url = "#{OPENWEATHERMAP_API_URL}#{endpoint}?q=#{city}&appid=#{OPENWEATHERMAP_API_KEY}&units=metric"
      end
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