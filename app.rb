require "sinatra"
require 'sinatra/activerecord'
require 'httparty'
require 'json'
require "sinatra/reloader" if development?

class App < Sinatra::Base

  get "/" do
  	@ttdem = HTTParty.get('http://ctabustracker.com/bustime/api/v2/getpredictions?key=uaAwsh6vFzfc4nc66z6YR6DNQ&rt=22&stpid=1836&format=json')
  	@tsdem = HTTParty.get('http://ctabustracker.com/bustime/api/v2/getpredictions?key=uaAwsh6vFzfc4nc66z6YR6DNQ&rt=36&stpid=1836&format=json')
  	@ttdiv = HTTParty.get('http://ctabustracker.com/bustime/api/v2/getpredictions?key=uaAwsh6vFzfc4nc66z6YR6DNQ&rt=22&stpid=1899&format=json')
  	@tsdiv = HTTParty.get('http://ctabustracker.com/bustime/api/v2/getpredictions?key=uaAwsh6vFzfc4nc66z6YR6DNQ&rt=36&stpid=5395&format=json')
    erb :index
  end

end