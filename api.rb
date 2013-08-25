require 'sinatra'
require 'dino'

configure do
  set :board, Dino::Board.new(Dino::TxRx.new)
end

get '/leds/on/:pin' do
  led(params[:pin]).on

  "Turned on led at pin #{params[:pin]}"
end

get '/leds/off/:pin' do
  led(params[:pin]).off

  "Turned off led at pin #{params[:pin]}"
end

private

def led pin
  Dino::Components::Led.new pin: pin, board: settings.board
end
