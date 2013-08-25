require './api'
require 'rack/test'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Api' do
  context 'leds' do
    before do
      stub_const 'Dino::Components::Led', dino_component_led_const
    end

    let(:dino_component_led_const) { double :dino_component_led_const }
    let(:led) { double :led }

    it 'turns on' do
      dino_component_led_const.should_receive(:new).with({ pin: '13', board: app.settings.board }).and_return led
      led.should_receive :on
      get '/leds/on/13'

      expect(last_response.body).to eq 'Turned on led at pin 13'
    end

    it 'turns off' do
      dino_component_led_const.should_receive(:new).with({ pin: '12', board: app.settings.board }).and_return led
      led.should_receive :off
      get '/leds/off/12'

      expect(last_response.body).to eq 'Turned off led at pin 12'
    end
  end
end
