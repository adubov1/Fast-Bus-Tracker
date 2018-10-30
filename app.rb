require 'sinatra'
require 'sinatra/activerecord'
require 'httparty'
require 'json'
require 'sinatra/reloader' if development?
require 'yaml'
require 'barnes'
class App < Sinatra::Base
	Barnes.start

	def conv(x)
		((Time.parse(x).to_f-Time.now.getlocal('-05:00').to_f)/60)+300 rescue nil
	end

	def getRoutes
		cta_key = YAML.load(File.read("secret/cta_key.yml"))["key"]
		@ttdem = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"]))
		@tsdem = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"]))
		@ttdiv = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1899&format=json")["bustime-response"]["prd"][0]["prdtm"]))
		@tsdiv = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=5395&format=json")["bustime-response"]["prd"][0]["prdtm"]))
		@ttdem2 = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1836&format=json")["bustime-response"]["prd"][1]["prdtm"]))
		@tsdem2 = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=1836&format=json")["bustime-response"]["prd"][1]["prdtm"]))
		@ttdiv2 = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1899&format=json")["bustime-response"]["prd"][1]["prdtm"]))
		@tsdiv2 = conv((HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=5395&format=json")["bustime-response"]["prd"][1	]["prdtm"]))
	end


	get "/" do
		getRoutes
		erb :index
	end

end