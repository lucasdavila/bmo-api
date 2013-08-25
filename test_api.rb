require './api'
require 'minitest/autorun'
require 'rack/test'

class TestApi < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_turn_on_led
    get '/leds/on/13'
    assert_equal 'Turned on led at pin 13', last_response.body
  end

  def test_turn_off_led
    get '/leds/off/14'
    assert_equal 'Turned off led at pin 14', last_response.body
  end
end
