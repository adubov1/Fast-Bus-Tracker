require 'sinatra'
require 'sinatra/activerecord'
require 'httparty'
require 'json'
require 'sinatra/reloader' if development?
require 'yaml'

class App < Sinatra::Base

	def getRoutes
		cta_key = YAML.load(File.read("secret/cta_key.yml"))["key"]
		@ttdem = HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"].insert(4," ").insert(7," ").insert(10," ")
		@tsdem = HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"].insert(4," ").insert(7," ").insert(10," ")
		@ttdiv = HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1899&format=json")["bustime-response"]["prd"][0]["prdtm"].insert(4," ").insert(7," ").insert(10," ")
		@tsdiv = HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=5395&format=json")["bustime-response"]["prd"][0]["prdtm"].insert(4," ").insert(7," ").insert(10," ")
		
	end


	get "/" do
		getRoutes
		erb :index
	end

end