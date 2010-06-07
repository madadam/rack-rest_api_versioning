# encoding: utf-8

require 'rake'
require 'rake/testtask'
 
desc 'Default: run unit tests.'
task :default => :test
 
desc 'Run unit tests.'
Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

begin
  require 'jeweler'

  Jeweler::Tasks.new do |gemspec|
    gemspec.name     = 'rack-rest_api_versioning'
    gemspec.summary  = 'A Rack middleware to support "the proper way" to version a RESTful API.'
    gemspec.description = "This midleware allows an application to support multiple versions of a RESTful API following the best RESTful practices to encode the version information in the HTTP request. It's inspired by this article: http://barelyenough.org/blog/2008/05/versioning-rest-web-services/."

    gemspec.email    = 'adam.ciganek@gmail.com'
    gemspec.homepage = 'http://github.com/madadam/rack-rest_api_versioning'
    gemspec.authors  = ['Adam Cigánek']

    gemspec.add_dependency 'rack'
  end

  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: gem install jeweler"
end
