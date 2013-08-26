require './api'
require 'rack/test'

def app
  Sinatra::Application
end

describe 'Api' do
  include Rack::Test::Methods

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

    context 'fade' do
      before do
        app.settings.stub_chain board: board
      end

      let(:board) { double :board }

      it 'fades in' do
        0.upto(255) { |to|
          board.should_receive(:analog_write).with '11', to
        }
        app.any_instance.should_receive(:sleep).exactly(256).times.with 0.01

        put 'leds/fade_in/11'

        expect(last_response.body).to eq 'Faded in led at pin 11'
      end

      it 'fades in with a given sleep time' do
        0.upto(255) { |to|
          board.should_receive(:analog_write).with '11', to
        }
        app.any_instance.should_receive(:sleep).exactly(256).times.with 0.03

        put 'leds/fade_in/11', { sleep: 0.03 }

        expect(last_response.body).to eq 'Faded in led at pin 11'
      end

      it 'fades out' do
        255.downto(0) { |to|
          board.should_receive(:analog_write).with '11', to
        }
        app.any_instance.should_receive(:sleep).exactly(256).times.with 0.01

        put 'leds/fade_out/11'

        expect(last_response.body).to eq 'Faded out led at pin 11'
      end

      it 'fades out with a given sleep time' do
        255.downto(0) { |to|
          board.should_receive(:analog_write).with '11', to
        }
        app.any_instance.should_receive(:sleep).exactly(256).times.with 0.03

        put 'leds/fade_out/11', { sleep: 0.03 }

        expect(last_response.body).to eq 'Faded out led at pin 11'
      end

      it 'fades to a given value' do
        board.should_receive(:analog_write).with '11', '100'

        put 'leds/fade/11', { to: 100 }

        expect(last_response.body).to eq 'Faded led at pin 11 to value 100'
      end
    end
  end
end
