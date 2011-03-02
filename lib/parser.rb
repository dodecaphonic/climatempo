# -*- coding: utf-8 -*-
require 'open-uri'
require 'nokogiri'

module ClimaTempo
  class Forecast
    attr_reader :date, :min, :max, :precipitation,
                :probability, :conditions

    def initialize(date, min, max,
                   precipitation=nil, probability=nil, conditions=nil)
      @date = date
      @min = min
      @max = max
      @precipitation = precipitation
      @probability = probability
      @conditions = conditions
    end
  end

  class Parser
    def self.parse(io)
      doc = Nokogiri::XML(io)

      places = {}

      doc.search('item').each do |item|
        place = item.search('title')[0].content.
          scan(/(\S+)\s+-/).flatten[0]
        data  = item.search('description')[0].content.
          split("\n").delete_if { |l| l.empty? }

        forecasts = data.map do |line|
          date, min, max, prec, prob, conditions = line.scan(/\(<b>(.*?)<\/b>\).*?Min:\s+(\d+).*?Máx:\s+(\d+).*?Prec:\s+(\S+).*?Prob:\s+(\S+).*?Condição:\s+(.*)<br \/>/).flatten

          date = DateTime.new(DateTime.now.year,
                              *date.scan(/\d+/).map { |n| n.to_i }.reverse)

          Forecast.new date, "#{min}ºC", "#{max}ºC", prec, prob,
                       conditions
        end

        places[place] = forecasts
      end

      places
    end
  end
end

