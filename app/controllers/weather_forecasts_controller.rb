class WeatherForecastsController < ApplicationController
  before_action :geolocate_user, only: %i[current_weather forecast_weather]

  def get_weather_data(action)
    city         = params[:city] || geolocate_user
    weather_data = WeatherService.send(action, city)
    render json: weather_data
  end

  def current_weather
    get_weather_data(:current_weather)
  end

  def forecast_weather
    get_weather_data(:weather_forecast)
  end

  private

  def geolocate_user
    ip_address    = request.ip
    location_data = Geocoder.search(ip_address).first
    return nil if location_data.nil? || location_data.city.blank?

    location_data.city
  end

end


