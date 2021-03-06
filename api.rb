require 'sinatra'
require 'dino'

configure do
  set :board, Dino::Board.new(Dino::TxRx.new)
end

get '/leds/on/:pin' do
  led(params[:pin]).on
end

get '/leds/off/:pin' do
  led(params[:pin]).off
end

put '/leds/fade_in/:pin' do
  0.upto(255) { |to|
    settings.board.analog_write params[:pin], to
    sleep (params[:sleep] || 0.01).to_f
  }
end

put '/leds/fade_out/:pin' do
  255.downto(0) { |to|
    settings.board.analog_write params[:pin], to
    sleep (params[:sleep] || 0.01).to_f
  }
end

put '/leds/fade/:pin' do
  settings.board.analog_write params[:pin], params[:to]
end

private

def led pin
  Dino::Components::Led.new pin: pin, board: settings.board
end
