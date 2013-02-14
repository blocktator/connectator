require 'rake'
require 'rake/testtask'
require 'rdoc/task'

task :test do
  system("bundle exec rspec spec/**/*")
end

task :build_gem do
  system("bundle exec gem build connectator.gemspec")
end

task :push_gem do
  system("bundle exec gem build connectator.gemspec")
end

task :default => [:test]
