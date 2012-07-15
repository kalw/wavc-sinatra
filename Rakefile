APP = "wavc-sinatra"

  require 'wavc'
  require 'rack/test'
  require 'test/unit'


desc "Test Wavc"
task :run => "Gemfile.lock" do

	class WavcTest < Test::Unit::TestCase
	  include Rack::Test::Methods
	
	  def app
	    Sinatra::Application
	  end
	
	  def test_it_runs
	    get '/'
#	    assert last_response.ok?
	    last_response.body.include?('HOME')
	  end

	  def test_it_connects
	    get '/path/'
	    assert last_response.ok?
	    last_response.body.include?('HOME')
	  end

	  def test_it_connects_and_list_ressources
	    get '/path/0'
	    assert last_response.ok?
	    last_response.body.include?('HOME')
	  end

	  def test_it_gather_info_from_video
	    get '/info.html', :path => '0/0'
	    assert last_response.ok?
	    last_response.body.include?('HOME')
	  end

	end

end

# need to touch Gemfile.lock as bundle doesn't touch the file if there is no change
file "Gemfile.lock" => "Gemfile" do
  sh "bundle && touch Gemfile.lock"
end

task :default => 'run'
