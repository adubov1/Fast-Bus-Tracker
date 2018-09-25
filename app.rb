require "sinatra"
require 'sinatra/activerecord'

class App < Sinatra::Base
  get "/" do
    erb :"/app/views/index"
  end
end