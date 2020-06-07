ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

task :environment do
  require File.expand_path(File.join(*%w[ config environment ]), File.dirname(__FILE__))
end

task :console do
  Pry.start
end

# Type `rake -T` on your command line to see the available rake tasks.