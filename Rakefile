#!/usr/bin/env rake
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :console do
  require 'pry'
  require 'rails'
  require 'datatables-net'
  ARGV.clear
  Pry.start
end
