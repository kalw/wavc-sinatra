APP = "wavc-sinatra"

desc "run app locally"
task :run => "Gemfile.lock" do
  require 'app'
  Sinatra::Application.run!
end

# need to touch Gemfile.lock as bundle doesn't touch the file if there is no change
file "Gemfile.lock" => "Gemfile" do
  sh "bundle && touch Gemfile.lock"
end
