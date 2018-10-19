require 'sinatra'
require 'sinatra/activerecord'
require 'httparty'
require 'json'
require 'sinatra/reloader' if development?
require 'yaml'
require 'barnes'
class App < Sinatra::Base
	Barnes.start
	def getRoutes
		cta_key = YAML.load(File.read("secret/cta_key.yml"))["key"]
		@ttdem = ((Time.parse(HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"]).to_f-Time.now.getlocal('-05:00').to_f)/60)+300 rescue nil
		@tsdem = ((Time.parse(HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=1836&format=json")["bustime-response"]["prd"][0]["prdtm"]).to_f-Time.now.getlocal('-05:00').to_f)/60)+300 rescue nil
		@ttdiv = ((Time.parse(HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=22&stpid=1899&format=json")["bustime-response"]["prd"][0]["prdtm"]).to_f-Time.now.getlocal('-05:00').to_f)/60)+300 rescue nil
		@tsdiv = ((Time.parse(HTTParty.get("http://ctabustracker.com/bustime/api/v2/getpredictions?key=#{cta_key}&rt=36&stpid=5395&format=json")["bustime-response"]["prd"][0]["prdtm"]).to_f-Time.now.getlocal('-05:00').to_f)/60)+300 rescue nil
	end


	get "/" do
		getRoutes
		erb :index
	end

end