require 'vcr'

require File.expand_path("../../lib/climatempo", __FILE__)

VCR.configure do |c|
  c.cassette_library_dir = File.join(File.dirname(__FILE__), 'fixtures', 'vcr_cassettes')
  c.hook_into :fakeweb
end
