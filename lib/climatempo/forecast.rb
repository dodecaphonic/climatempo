module ClimaTempo
  class Forecast
    attr_reader :date, :min, :max, :now, :precipitation,
                :probability, :conditions, :pressure,
                :humidity

    def initialize(date, opts={})
      @date = date
      @min  = opts[:min]
      @max  = opts[:max]
      @now  = opts[:now]
      @precipitation = opts[:precipitation]
      @probability   = opts[:probability]
      @conditions    = opts[:conditions]
      @pressure      = opts[:pressure]
      @humidity      = opts[:humidity]
    end

    def today?
      now = DateTime.now
      now.year == date.year &&
        now.month == date.month &&
        now.day == date.day
    end

    def to_s
      "Temp: (#{max}/#{min}); Humidity: #{humidity}; Precipitation: #{precipitation}; Prob. of rain: #{probability}; Conditions: #{conditions}; Air pressure: #{pressure}"
    end
  end
end
