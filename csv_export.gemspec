# -*- encoding: utf-8 -*-
require File.expand_path('../lib/csv_export/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Sergey Pchelincev"]
  gem.email         = ["jalkoby91@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "csv_export"
  gem.require_paths = ["lib"]
  gem.version       = CsvExport::VERSION

  gem.add_dependency 'activesupport'
  gem.add_dependency 'actionpack'
  gem.add_dependency 'fastercsv', '1.5.5'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_development_dependency 'debugger' if RUBY_VERSION =~ /1.9/
end
