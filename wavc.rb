require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'airvideo'
require 'yaml'

CONFIG = YAML::load(File.open('settings.yml')) unless defined? CONFIG

class Wavc 
	def walk(path)
		depth = 1
		idx = 0
		list = Array.new(2, Hash.new)
		item = Array.new(2, Hash.new)	
		item[0]['command'] = "AirVideo::Client.new('#{CONFIG["airvideo_server"]}','#{CONFIG["airvideo_port"]}','#{CONFIG["airvideo_passwd"]}').ls"	
		puts path
		path = path.split("/")
		puts path
		path.each do |gate|		
			item[depth]['command'] += "[#{gate}].ls" 
		end
		puts "#{item[depth]['command']}"
		item[depth]['length'] = (eval item[depth]['command']).length
		puts "#{item[depth]['length']}"
			(eval item[depth]['command']).each do |enum|
					list[idx] = {"name" => enum.name, "class" => enum.class, "idx" => idx , "path" => path } 
					idx += 1
			end	
		return list
	end
end

get %r{/path/(([\d]\/?)*)} do
	content = Wavc.new.walk(params[:captures].first)
	puts request.path
	erb:index,:locals => {:content => content,:request => request.path}
end

