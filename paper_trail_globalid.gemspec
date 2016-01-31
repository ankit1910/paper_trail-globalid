# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'paper_trail_globalid/version'

Gem::Specification.new do |spec|
  spec.name          = "paper_trail_globalid"
  spec.version       = PaperTrailGlobalid::VERSION
  spec.authors       = ["Ankit"]
  spec.email         = ["ankit.bansal1910@gmail.com"]
  spec.summary       = "An extension to paper_trail, using this you can fetch actual object who was responsible for this change"
  spec.description   = "An extension to paper_trail, using this you can fetch actual object who was responsible for this change"
  spec.homepage      = "https://github.com/ankit1910/paper_trail-globalid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'paper_trail', '>= 3.0.0'
  spec.add_dependency 'globalid'

  spec.add_development_dependency 'appraisal', '~> 2.1'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
