class WeatherForecastsController < ApplicationController

  def get_weather_data(action)
    weather_data = WeatherService.send(action, params[:city], params[:latitude], params[:longitude])
    render json: weather_data
  end

  def current_weather
    get_weather_data(:current_weather)
  end

  def forecast_weather
    get_weather_data(:weather_forecast)
  end

end


