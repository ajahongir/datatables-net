require 'pry'
require 'rails'
require 'active_record'
require 'datatables-net'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

load File.dirname(__FILE__) + '/schema.rb'
load File.dirname(__FILE__) + '/test_helpers.rb'
require File.dirname(__FILE__) + '/test_models.rb'
