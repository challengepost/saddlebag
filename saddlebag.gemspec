# -*- encoding: utf-8 -*-
require File.expand_path('../lib/saddlebag/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ross Kaffenberger"]
  gem.email         = ["rosskaff@gmail.com"]
  gem.summary       = %q{A Rails 3+ toolkit}
  gem.homepage      = "https://github.com/challengepost/saddlebag"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "saddlebag"
  gem.require_paths = ["lib"]
  gem.version       = Saddlebag::VERSION

  gem.add_dependency "activesupport", ">= 3.0"

  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_development_dependency "rake"


  gem.description   = <<-DESC
Saddlebag bundles some helpful tools for configuring Rails 3+ projects.
DESC
end
