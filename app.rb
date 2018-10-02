require "sinatra"
require 'sinatra/activerecord'
require 'httparty'
require 'json'

class App < Sinatra::Base
  
  get "/" do
  	@twentytwodem = HTTParty.get('http://ctabustracker.com/bustime/api/v2/getpredictions?key=uaAwsh6vFzfc4nc66z6YR6DNQ&rt=22&stpid=1836&format=json')
    erb :index :twentytwodem

  end

end