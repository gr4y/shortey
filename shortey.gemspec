# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shortey/version'

Gem::Specification.new do |gem|
  gem.name          = "shortey"
  gem.version       = Shortey::VERSION
  gem.authors       = ["Sascha Wessel"]
  gem.email         = ["swessel@gr4yweb.de"]
  gem.description   = %q{an url-shortener based on rack and redis}
  gem.summary       = %q{an url-shortener based on rack and redis}
  gem.homepage      = "https://github.com/gr4y/shortey"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.required_ruby_version = "~> 1.9.2"

  gem.add_runtime_dependency "nyny", "~> 2.0.0"
  gem.add_runtime_dependency "redis", "~> 3.0.2"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "~> 2.14.1"
  gem.add_development_dependency "rack-test", "~> 0.6.2"

end
