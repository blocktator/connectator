Gem::Specification.new do |s|
  s.name        = 'connectator'
  s.version     = '0.0.1'

  s.date        = '2013-02-14'
  s.summary     = "Multi DBMS connection abstraction"
  s.description = "This gem lets you make connections to multiple kinds of DBMS systems through DBI"
  s.authors     = ["Benjamin Wagaman"]
  s.email       = 'ben@wagaman.org'
  s.files       = ["lib/connectator.rb"]
  s.homepage    = 'http://rubygems.org/gems/connecator'

  s.add_runtime_dependency "dbi", [">= 0.4.5"]
  s.add_runtime_dependency "dbd-odbc", [">= 0.2.5"]
end
