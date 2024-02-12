require 'rails_helper'

RSpec.describe WeatherForecastsController, type: :controller do
  describe 'GET #forecast_weather' do
    it 'returns the weather forecast data with the main temp' do
      allow(controller).to receive(:geolocate_user).and_return('Paris')
      get :forecast_weather, params: { city: 'Paris' }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include('application/json')

      forecast_data = JSON.parse(response.body)

      expect(forecast_data['list'][0]['main']).to have_key('temp')
    end
  end

  describe 'GET #current_weather' do
    it 'returns the current weather data with the main temp' do
      allow(controller).to receive(:geolocate_user).and_return('Paris')
      get :current_weather, params: { city: 'Paris' }
      expect(response).to have_http_status(:success)
      expect(response.content_type).to include('application/json')

      weather_data = JSON.parse(response.body)

      expect(weather_data['main']).to have_key('temp')
    end
  end
end
