lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'datatables-net/version'

Gem::Specification.new do |gem|
  gem.name          = "datatables-net"
  gem.version       = DatatablesNet::VERSION
  gem.authors       = ["Joel Quenneville"]
  gem.email         = ["joel.quenneville@collegeplus.org"]
  gem.description   = %q{A gem that simplifies using datatables and hundreds of records via ajax}
  gem.summary       = %q{A wrapper around datatable's ajax methods that allow synchronization with server-side pagination in a rails app}
  gem.homepage      = ""
  gem.required_ruby_version = Gem::Requirement.new(">= 2.0.0")

  gem.files = Dir["{lib,spec}/**/*", "[A-Z]*"] - ["Gemfile.lock"]
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_path = "lib"

  gem.add_dependency 'railties',   '>= 3.2'

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "generator_spec"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "sqlite3"
  gem.add_development_dependency "rails", ">= 3.2.0"
  gem.add_development_dependency "activerecord", ">= 4.1.6"
end
