require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'airvideo'
require 'yaml'

CONFIG = YAML::load(File.open('settings.yml')) unless defined? CONFIG

class Wavc 
	def walk(path)
		depth = 0
		idx = 0
		list = Array.new(2, Hash.new)
		item = Array.new(2, Hash.new)	
		item[depth]['command'] = "AirVideo::Client.new('#{CONFIG["airvideo_server"]}','#{CONFIG["airvideo_port"]}','#{CONFIG["airvideo_passwd"]}').ls"	
		path = path.split("/")
		path.each do |gate|		
			item[depth]['command'] += "[#{gate}].ls" 
		end
		puts "Command : #{item[depth]['command']}"
		puts "Path : #{path}"
		item[depth]['length'] = (eval item[depth]['command']).length
		puts "Returned records  : #{item[depth]['length']}"
			(eval item[depth]['command']).each do |enum|
				puts "Item name  : #{enum.name}"
				puts "Item class :  #{enum.class}"
				if enum.class == AirVideo::Client::VideoObject 
					url = "#{enum.url}"  
					puts "Item url: #{url}"
					#liveurl = enum.live_url  
					#puts "liveurl: #{liveurl}"
				else 
					url = nil
					liveurl = nil
				end
				list[idx] = {"name" => enum.name, "class" => enum.class, "idx" => idx , "path" => path , "url" => url , "liveurl" => liveurl} 
				idx += 1
			end	
		return list
	end
end

get '/' do
  redirect '/path/'
end

get '/divxwebplayer.html' do
	url = params[:url]
	puts "url : #{url}"
	erb:divxwp,:locals => {:url => url }
end

get %r{/path/(([\d]\/?)*)} do
	content = Wavc.new.walk(params[:captures].first)
	puts "Request path: #{request.path}"
	path = params[:captures].first
	path = path.split("/")
	puts "Forwarded path : #{path}"
	erb:index,:locals => {:content => content,:request => request.path, :path => path }
end

