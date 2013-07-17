Gem::Specification.new do |s|
  s.name        = "streak_client"
  s.version     = "0.0.0"
  s.date        = "2013-07-12"
  s.summary     = "Streak API Client"
  s.description = "Client for the Streak REST API"
  s.authors     = ["Kristof"]
  s.email       = "kristof@hush.com"
  s.files       = Dir.glob("lib/**/*.rb")
  s.license     = "MIT"
  s.homepage    = "http://rubygems.org/gems/streak_client"

  s.add_dependency("rest-client")
  s.add_dependency("multi_json")

end
