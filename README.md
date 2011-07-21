# WAVC




## INSTALLATION


### ALL PLATEFORMS


**Optionnal**

	$ gem install thin

**Mandatory**

	$ gem install airvideo
	$ gem install sinatra
	$ 


### WINDOWS PLATEFORM


1. [Download](http://rubyinstaller.org/downloads/) and install Ruby for Windows
	
**Otionnal**

1. Install Rack.

	c:\> gem install rack

1. [Download](http://rubyforge.org/frs/download.php/23665/eventmachine-win32-0.8.1.gem) EventMachine 0.8.1


1. Install EventMachine locally

	c:\> gem install eventmachine -l

1. Install Ruby Thin Server, but ignore dependencies

	c:\> gem install thin --ignore-dependencies


**Mandatory**

1. Install Airvideo Lib


	c:\> gem install airvideo
1. Install Sinatra

	c:\> gem install sinatra


## USAGE



## CONFIGURATION

Copy settings-sample.yml to settings.yml

	$ cp settings-sample.yml settings.yml

Edit the 3 variables with server address, port and password of airvideo server.

	---
	airvideo_server: "0.0.0.0"
	airvideo_port: "45631"
	airvideo_passwd: "passwd" 

Launch the app

	$ ruby wavc.rb



## FAQ

**Q:**   
**A:** 



## CONTRIBUTING

Please report issues on the [Github issue
tracker](https://github.com/kalw/wavc-sinatra/issues)


## License



