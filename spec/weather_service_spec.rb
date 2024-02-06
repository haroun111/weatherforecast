require 'rails_helper'

RSpec.describe WeatherService do
  describe '.current_weather' do
    it 'returns current weather data for a city' do
      VCR.use_cassette('current_weather') do
        city = 'London'
        weather_data = WeatherService.current_weather(city)
        expect(weather_data).to be_instance_of(Hash)
        expect(weather_data).to have_key('main')
        expect(weather_data['name']).to eq(city)
      end
    end
  end

  describe '.weather_forecast' do
    it 'returns weather forecast data for a city' do
      VCR.use_cassette('weather_forecast') do
        city = 'Paris'
        weather_data = WeatherService.weather_forecast(city)
        expect(weather_data).to be_instance_of(Hash)
        expect(weather_data).to have_key('list')
        expect(weather_data['city']['name']).to eq(city)
      end
    end
  end
end
