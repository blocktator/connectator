require 'rake'
require 'rake/testtask'
require 'rdoc/task'

task :test do
  system("bundle exec rspec spec -cfn")
end

task :build_gem do
  system("bundle exec gem build connectator.gemspec")
end

task :push_gem => [:build_gem] do
  puts "Command to run: "
  puts "  gem push connectator-0.0.x.gem"
end

task :default => [:test]
