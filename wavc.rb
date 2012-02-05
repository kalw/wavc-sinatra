require 'rubygems' if RUBY_VERSION < "1.9"
require 'sinatra'
require 'airvideo'
require 'yaml'
require 'logger'

CONFIG = YAML::load(File.open('settings.yml')) unless defined? CONFIG

log_file = File.open('wavc.log', 'a+')
log_file.sync = true 
logger = Logger.new(log_file) 
set :logger, logger
def logger; settings.logger; end 
if CONFIG["airvideo_debug"] == "yes"
logger.level = Logger::DEBUG 
else
logger.level = Logger::ERROR
end

Command = AirVideo::Client.new( "#{CONFIG["airvideo_server"]}" , "#{CONFIG["airvideo_port"]}" , "#{CONFIG["airvideo_passwd"]}" )	

helpers do
	def divxplayer(url)
	  html = <<-EOF
		<object classid="clsid:67DABFBF-D0AB-41fa-9C46-CC0F21721616" 
			width="320"
			height="260"
			codebase="http://go.divx.com/plugin/DivXBrowserPlugin.cab" >
		<param name="custommode" value="none" />
		<param name="autoPlay" value="false" />
		<param name="src" value="#{url}" />
		<embed type="video/divx"
			src="#{url}"
			custommode="none"
			width="320"
			height="260"
			autoPlay="false"
			pluginspage="http://go.divx.com/plugin/download/"
		</embed>
		</object>
		<br />No video? <a href="http://www.divx.com/software/divx-plus/web-player" target="_blank">Download</a> the DivX Plus Web Player.
	  EOF
	end

	def clippy(text, bgcolor='#FFFFFF')
	  html = <<-EOF
	    <object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000"
	            width="130"
	            height="16"
	            id="clippy" >
	    <param name="movie" value="/flash/clippy.swf"/>
	    <param name="allowScriptAccess" value="always" />
	    <param name="quality" value="high" />
	    <param name="scale" value="noscale" />
	    <param NAME="FlashVars" value="text=#{text}">
	    <param name="bgcolor" value="#{bgcolor}">
	    <param name="wmode" value="transparent"></param>
	    <embed src="/flash/clippy.swf"
	           width="130"
	           height="16"
	           name="clippy"
	           quality="high"
	           allowScriptAccess="always"
	           type="application/x-shockwave-flash"
	           pluginspage="http://www.macromedia.com/go/getflashplayer"
	           FlashVars="text=#{text}"
	           bgcolor="#{bgcolor}"
		   wmode="transparent"
	    />
	    </object>
	  EOF
	end

end

class Wavc 
	def walk(path)
		idx  = 0
		list = Array.new(2, Hash.new)
		item = "Command.ls"
		path = path.split( "/" )
		path.each do |gate|		
			item += "[#{gate}].ls" 
		end
		logger.debug  "Gate : #{item}"
		logger.debug  "Path : #{path}"
			(eval item).each do |enum|
				logger.debug  "Item name  : #{enum.name}"
				logger.debug  "Item class :  #{enum.class}"
				list[idx] = {"name" => enum.name, "class" => enum.class, "idx" => idx , "path" => path  } 
				idx += 1
			end	
		return list
	end
	def info(path)
		item = "Command.ls"
		idx = 1
		itemPath = path.split( "/" )
		logger.debug "ItemPath : #{itemPath.inspect}" 
		logger.debug "ItemLength : #{itemPath.length}" 
		itemPath.each do |gate|		
			item += "[#{gate}].ls" if idx != itemPath.length
			item += "[#{gate}]" if idx == itemPath.length
			idx += 1
		end
		logger.debug "ItemPathCommand : #{item}" 
		list = {"name" => (eval item).name ,"url" => (eval item).url}
		return list

	end
end

get '/' do
  redirect '/path/'
end

get '/divxwebplayer.html' do
	url = params[:url]
	logger.debug  "url : #{url}"
	erb:divxwp,:locals => {:url => url }
end

get '/info.html' do
	path = params[:path]
	content = Wavc.new.info(params[:path])
	logger.debug  "path : #{path}"
	logger.debug  "content : #{content.inspect}"
	erb:info,:locals => {:content => content }
end

get %r{/path/(([\d]\/?)*)} do
	content = Wavc.new.walk(params[:captures].first)
	logger.debug  "Content: #{content.inspect}"
	logger.debug  "Resquest Path: #{request.path}"
	path = params[:captures].first
	logger.debug  "Forwarded path : #{path}"
	erb:index,:locals => {:content => content, :request => request.path, :path => path}
end

