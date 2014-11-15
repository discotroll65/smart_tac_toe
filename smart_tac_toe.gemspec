# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'smart_tac_toe/version'

Gem::Specification.new do |spec|
  spec.name          = "smart_tac_toe"
  spec.version       = SmartTacToe::VERSION
  spec.authors       = ["Garrett Simpson"]
  spec.email         = ["elgaricimo@gmail.com"]
  spec.summary       = %q{A gem that will enable one to set up a game of tic tac toe.}
  spec.description   = %q{A computer player will be created which will be unbeatable, and win if possible.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
