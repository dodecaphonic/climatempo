Gem::Specification.new do |s|
   s.name = "climatempo"
   s.version = "0.1.2"
   s.date = "2011-03-09"
   s.authors = ["Vitor Peres"]
   s.email = "dodecaphonic@gmail.com"
   s.summary = "Uses ClimaTempo to extract weather info for Brazilian capitals, regions and airports" 
   s.homepage = %q{http://github.com/dodecaphonic/climatempo}
   s.description = "Uses ClimaTempo to extract weather info for Brazilian capitals, regions and airports"
   s.files = ["lib/climatempo.rb", "lib/climatempo/parser.rb", "lib/climatempo/weather.rb", "spec/integration/api_integration_spec.rb", "spec/integration/climatempo_parser_integration_spec.rb", "Rakefile", "README.md"]
   s.rubyforge_project = 'climatempo'
   s.has_rdoc = false
   s.test_files = ["spec/integration/api_integration_spec.rb", "spec/integration/climatempo_parser_integration_spec.rb"]
   s.add_dependency 'nokogiri'
end
