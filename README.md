# WAVC




## INSTALLATION


	$ gem install sinatra
	$ gem install airvideo-ng
	$ gem install airplay
	$ gem install logger
	$ git clone https://kalw@github.com/kalw/wavc-sinatra.git


## USAGE

#### Go into the application folder
	
	$ cd wavc-sinatra

#### Copy settings-sample.yml to settings.yml

	$ cp settings-sample.yml settings.yml

#### Edit the 3 variables with server address, port and password of the airvideo server.

	---
	airvideo_server: "0.0.0.0"
	airvideo_port: "45631"
	airvideo_passwd: "passwd" 

#### Launch the app

	$ ruby wavc.rb

#### Connect to http://localhost:4567/path/

## FAQ

**Q:**   
**A:** 

## TODO

Have a look at the [Wiki](https://github.com/kalw/wavc-sinatra/wiki)

## CONTRIBUTING

Please report issues on the [Github issue
tracker](https://github.com/kalw/wavc-sinatra/issues)


## License



