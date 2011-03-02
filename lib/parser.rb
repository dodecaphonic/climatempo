# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'

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
  end

  class Parser
    def self.parse(io, type=:regular)
      doc = Nokogiri::XML(io)

      places = {}

      doc.search('item').each do |item|
        place = item.search('title')[0].content.
          scan(/(.*?)\s+-\s+Previsão/).flatten[0]
        data  = item.search('description')[0].content.
          split("\n").delete_if { |l| l.empty? }

        forecasts = data.map do |line|
          case type
          when :airports
            parse_airport line
          when :regions, :country
            parse_descriptive line
          else
            parse_regular line
          end
        end

        places[place] = forecasts
      end

      places
    end

    private
    def self.parse_regular(line)
      date, min, max, prec, prob, conditions = line.scan(/\(<b>(.*?)<\/b>\).*?Min:\s+(\d+).*?Máx:\s+(\d+).*?Prec:\s+(\S+).*?Prob:\s+(\S+).*?Condição:\s+(.*)<br \/>/).flatten

      Forecast.new extract_date(date),
                   :min => "#{min}ºC", :max => "#{max}ºC",
                   :precipitation => prec, :probability => prob,
                   :conditions => conditions
    end

    def self.parse_descriptive(line)
      date, conditions = line.
        scan(/\(<b>(.*)<\/b>\)\s+-\s+(.*?)<br \/>/).flatten

      Forecast.new extract_date(date), :conditions => conditions
    end

    def self.parse_airport(line)
      date, now, humidity, conditions, pressure  = line.
        scan(/\(<b>(.*)<\/b>\)<br \/>- Temperatura no momento:(\S+ºC)<br \/> - Umidade Relativa:(\S+%)<br \/> - Condição do tempo:(.*?)<br \/> - Pressão:((?:-)?\S+)/).flatten

      Forecast.new extract_date(date),
                   :now => now, :conditions => conditions,
                   :humidity => humidity, :pressure => pressure
    end

    def self.extract_date(raw)
      DateTime.new(DateTime.now.year,
                   *raw.scan(/\d+/).map { |n| n.to_i }.reverse)
    end
  end
end

