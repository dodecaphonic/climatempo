# climatempo

ClimaTempo provides weather forecasts for state capitals, airports and regions in Brazil. This lib attempts at consuming stuff out of it in a little less tiresome manner.

## Usage

    w = ClimaTempo::Weather.new
    w.[airports|capitals|brazil|regions].each do |place, forecasts|
      ...
    end
    
    rio = w.forecast_for("Rio de Janeiro")

## Dependencies

* [nokogiri][1]
* [rspec][2] (for tests)


[1]: http://nokogiri.org
[2]: http://rspec.info