# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sms_ukraine/version'

Gem::Specification.new do |spec|
  spec.name          = "sms_ukraine"
  spec.version       = SmsUkraine::VERSION
  spec.authors       = ["Vladimir Oberemok"]
  spec.email         = ["nihtalak@gmail.com"]
  spec.description   = %q{SMS delivery for Ukraine}
  spec.summary       = %q{SMS delivery for Ukraine uses http://smsukraine.com.ua/}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
