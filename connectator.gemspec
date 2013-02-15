Gem::Specification.new do |s|
  s.name        = 'connectator'
  s.version     = '0.0.5'

  s.date        = '2013-02-15'
  s.summary     = "Multi DBMS connection abstraction"
  s.description = "This gem lets you make connections to multiple kinds of DBMS systems through DBI"
  s.authors     = ["Benjamin Wagaman"]
  s.email       = 'ben@wagaman.org'
  s.files       = Dir["**/*.rb"] + Dir["README.md"] + Dir["example_odbcinst.ini"] 
  s.homepage    = 'https://github.com/jamin4jc/connectator'

  s.add_runtime_dependency "dbi", [">= 0.4.5"]
  s.add_runtime_dependency "dbd-odbc", [">= 0.2.5"]

  s.add_development_dependency "bundler"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec-given"
end
