$:.push File.expand_path("../lib", __FILE__)

require "ensconce/version"

Gem::Specification.new do |s|
  s.name        = "ensconce"
  s.version     = Ensconce::VERSION
  s.authors     = ["Rob Nichols"]
  s.email       = ["rob@undervale.co.uk"]
  s.homepage    = "https://github.com/reggieb/ensconce"
  s.summary     = "Personal Data Store Wrapper."
  s.description = "Wraps connections to Personal Data Stores, to allow data stores to changed. For example, to aid testing or swap data store provider"

  s.files = Dir["lib/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]
  
  s.add_dependency 'faraday'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'webmock'

end