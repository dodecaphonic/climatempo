# -*- coding: utf-8 -*-
require 'date'

module Factory
  def self.forecast_factory(min, max)
    (0...5).map do |i|
      f_min = rand(min)
      f_max = 0
      prec  = rand(41)
      prob  = rand(100)

      f_max = rand(max) while f_max < f_min

      Forecast.new DateTime.now + i, :min => "#{f_min}ºC",
      :max => "#{f_max}ºC", :precipitation => "#{prec}mm",
      :probability => "#{prob}%", :conditions => "Sol #{i}"
    end
  end

  def self.descriptive_forecast_factory(n=5)
    (0...n).map { |i|
      Forecast.new DateTime.now + i, :conditions => "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis a scelerisque justo. Sed mauris augue, accumsan nec pellentesque faucibus, ullamcorper sed metus. In sit amet risus velit. Aenean semper odio eget tortor laoreet viverra. Nam semper, nibh in auctor porttitor, eros velit pellentesque erat, sed iaculis arcu turpis eu lorem."
    }
  end

  def self.airport_factory
    [Forecast.new(DateTime.now, :now => "23ºC",
                 :conditions => "Muitas nuvens.",
                 :humidity => "71%",
                 :pressure => "1341 hPa")]
  end
end
