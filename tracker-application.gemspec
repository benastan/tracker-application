# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tracker/application/version'

Gem::Specification.new do |spec|
  spec.name          = "tracker-application"
  spec.version       = Tracker::Application::VERSION
  spec.authors       = ["Ben Bergstein"]
  spec.email         = ["bennyjbergstein@gmail.com"]
  spec.description   = "Application logic for a tracker app"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "interactor"
  spec.add_dependency "tracker-p_g"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "foreman"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
end
