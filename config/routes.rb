Rails.application.routes.draw do
  get 'forecast_weather/:city', to: 'weather_forecasts#forecast_weather', as: :weather_forecast
  get 'current_weather/:city', to: 'weather_forecasts#current_weather', as: :current_weather
end
