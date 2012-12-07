$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'climatempo/version'

Gem::Specification.new do |s|
  s.name = "climatempo"
  s.version = "0.2"
  s.date = "2012-12-06"
  s.authors = ["Vitor Capela"]
  s.email = "dodecaphonic@gmail.com"
  s.summary = "Uses ClimaTempo to extract weather info for Brazilian capitals, regions and airports"
  s.homepage = %q{http://github.com/dodecaphonic/climatempo}
  s.description = "Uses ClimaTempo to extract weather info for Brazilian capitals, regions and airports"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- spec`.split("\n")

  s.rubyforge_project = 'climatempo'
  s.has_rdoc = false

  s.add_dependency 'nokogiri'
  s.add_dependency 'httparty'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'vcr'
  s.add_development_dependency 'fakeweb'
  s.add_development_dependency 'rake'

  s.require_paths = ['lib']
end
